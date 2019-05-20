class BadgeGearService
  def initialize(user, test_passage)
    @user = user
    @test_taken = test_passage
    @test = @test_taken.test
    @earned_codes = []
    @rule_codes = BadgeRule.pluck(:code)
  end

  def find_badge(code)
    rule = BadgeRule.find_by(code: code)
    Badge.find_by(rule_id: rule.id)
  end

  def add_one_badge(badge, code)
    record_gear = BadgeGear.find_by(user_id: @user.id, badge_id: badge.id)
    record_gear.increment!(:badge_count)
    @earned_codes << code
  end

  def process_badge(code)
    badge = find_badge(code)
    return if badge.nil?

    if @user.badges.ids.exclude?(badge.id)
      @user.badges << badge
      # one-time count one-pass badges
      add_one_badge(badge, code) if BadgeRule.one_pass.include?(badge.rule.id)
    end
    # to not count already earned one-pass badges
    if @user.badges.exists?(badge.id) && BadgeRule.one_pass.exclude?(badge.rule.id)
      add_one_badge(badge, code)
    end
  end

  def call
    process_codes = []
    passed = TestPassage
             .passed_list
             .where(user_id: @user.id)
             .pluck(:test_id).uniq

    # TestGuru Participant Badge
    code_start = @rule_codes.detect { |rc| rc == 'TG-Start' }
    process_codes << code_start

    # Passed-in-one-Shot Badge
    record_uniq = TestPassage.where(user_id: @user.id, test_id: @test.id).count == 1
    if record_uniq
      code_shot = @rule_codes.detect { |rc| rc == 'TG-Shot' }
      process_codes << code_shot
    end

    # Basic Associate Badge
    simple_level = Test.simple.pluck(:id)
    if simple_level & passed == simple_level
      code_simple = @rule_codes.detect { |rc| rc == 'TG-Basic' }
      process_codes << code_simple
    end

    # Advanced Associate Badge
    adv_level = Test.moderate.pluck(:id)
    if adv_level & passed == adv_level
      code_adv = @rule_codes.detect { |rc| rc == 'TG-Adv' }
      process_codes << code_adv
    end

    # TestGuru BackEnd Prof Badge
    bkend = Test.scope_by_category('BackEnd').pluck(:id)
    if bkend & passed == bkend
      code_bkend = @rule_codes.detect { |rc| rc == 'TG-AllBkEnd' }
      process_codes << code_bkend
    end

    unless process_codes.empty?
      process_codes.each { |code| process_badge(code) }
    end
    @earned_codes
  end
end
