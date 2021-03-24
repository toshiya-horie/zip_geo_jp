RSpec.describe ZipGeoJp do
  it "has a version number" do
    expect(ZipGeoJp::VERSION).not_to be nil
  end

  it 'has record' do
    expect(ZipGeoJp['167-0021']).to be_a(ZipGeoJp::Record)
    expect(ZipGeoJp['1670021']).to be_a(ZipGeoJp::Record)
  end

  it 'no record' do
    expect(ZipGeoJp['9999999']).to be_nil
  end

end
