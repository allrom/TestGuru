class BadgeGearService
  def self.call(test_passage)
    new(test_passage).run
  end

  def initialize(test_passage)
    @user = test_passage.user
    @test = test_passage.test
    @earned_badges = []
  end

  def passed_tests
    TestPassage.passed_list.where(user_id: @user.id).pluck(:test_id).uniq
  end

  def run
    Badge.all.each do |badge|
      gear!(badge) if send("#{badge.rule.code}_rule_passed?", badge.rule.value)
    end
    @earned_badges
  end

  private

  def gear!(badge)
    earned_badge_desc = "#{badge.rule.value} #{badge.rule.code}".titlecase

    unless badge.rule.awarded_once
      @user.badges << badge
      @earned_badges << earned_badge_desc
    end

    if @user.badges.ids.exclude?(badge.id) && badge.rule.awarded_once
      @user.badges << badge
      @earned_badges << earned_badge_desc
    end
  end

  def category_rule_passed?(value)
    category_tests = Test.ids_by_category(value)
    category_tests & passed_tests == category_tests
  end

  def level_rule_passed?(value)
    level_values = BadgeRule.where(code: 'level').select(:value).map(&:value).uniq
    level_tests = Test.send("#{value}").ids if level_values.include? value
    level_tests & passed_tests == level_tests
  end

  def fast_start_rule_passed?(_value)
    TestPassage.where(user_id: @user.id, test_id: @test.id).count == 1
  end

  def start_rule_passed?(_value)
    true
  end
end
