require_relative '../edit_distance'

describe '字符串编辑距离' do
  let(:src) { 'snowy' }
  let(:dest) { 'sunny' }

  it '.edit_distance' do
    cost = edit_distance(src, dest)
    expect(cost).to eq 3
  end
end
