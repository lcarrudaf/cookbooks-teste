node['MICRODATA']['PROD'].each do |lyr|

  directory 'C:\\Temp' do
    action :create
    recursive true
  end

  seven_zip_archive "#{node['MICRODATA']['PROD']}#{lyr['name']}" do
    path      "#{node['MICRODATA']['TEMPATH']}#{lyr['name']}"
    source    "#{node['MICRODATA']['TEMPATH']}#{lyr['name']}#{lyr['version']}"
    overwrite true
    action :extract
  end

end

node['Service']['PROD'].each do |service|

  seven_zip_archive "#{node['Service']['PROD']}#{service['name']}" do
    path      "#{node['MICRODATA']['TEMPATH']}#{service['path']}"
    source    "#{node['MICRODATA']['TEMPATH']}#{service['name']}#{service['version']}"
    overwrite true
    action :extract
  end

end