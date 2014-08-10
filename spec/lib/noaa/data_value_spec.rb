require 'spec_helper'

describe DataValue do
  let(:data_value) { DataValue.new(7, 'F') }
  subject { data_value }
  it { should respond_to :unit }
  it { should respond_to :unit= }
  it { should respond_to :parameter }
  it { should respond_to :parameter= }
  it { should respond_to :value }
  it { should respond_to :value= }
  it { should respond_to :start_time }
  it { should respond_to :start_time= }
  it { should respond_to :end_time }
  it { should respond_to :end_time= }
end
