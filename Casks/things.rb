cask 'things' do
  version :latest
  sha256 :no_check

  # culturedcode.cachefly.net was verified as official when first introduced to the cask
  url 'https://culturedcode.cachefly.net/things/Things3.zip'
  name 'Things3'
  homepage 'https://culturedcode.com/things/'

  app 'Things3.app'
end

