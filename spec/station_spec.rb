require 'station'

describe Station do

  it 'shows name variable' do
    expect(subject.name).to eq("Old Street")
  end

  it 'shows zone variable' do
    expect(subject.zone).to eq(1)
  end

end
