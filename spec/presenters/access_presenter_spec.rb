require 'rails_helper'

class FakePresenter < BasePresenter
  def initialize(model, view_context)
    access_presenter = AccessPresenter.new model, view_context
    super access_presenter, view_context
  end

  def responsible_user
    model.responsible_user
  end
end

class FakeContext
  def initialize(policy)
    @policy = policy
  end

  def policy(*)
    @policy
  end
end

class FakeProjectPolicy
  def readable_attributes
    %i[responsible_user]
  end
end

class FakeProjectPolicyWithId
  def readable_attributes
    %i[responsible_user_id]
  end
end

RSpec.describe 'AccessPresenter', type: :presenter do
  context 'readable attributes' do
    let(:project) { create :project }
    let(:current_user) { create :administrator }

    it 'should return values if association attribute without id' do
      context = FakeContext.new(FakeProjectPolicy.new)
      presenter = FakePresenter.new(project, context)
      expect(presenter.responsible_user_id).to be_present
      expect(presenter.responsible_user).to be_present
    end
    it 'should return values if association attribute with id' do
      context = FakeContext.new(FakeProjectPolicyWithId.new)
      presenter = FakePresenter.new(project, context)
      expect(presenter.responsible_user_id).to be_present
      expect(presenter.responsible_user).to be_present
    end
  end
end