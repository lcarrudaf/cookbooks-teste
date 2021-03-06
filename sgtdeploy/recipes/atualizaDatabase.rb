bag = data_bag_item("sgtdeploy", "files")
orig = "C:\\Temp\\" + bag["VERSION"] + "\\IIS\\GTC\\AtualizaBanco\\Scripts"
iis_gtc = node["SGT"]["IIS_GTC"]
dest = iis_gtc + "\\AtualizaBanco\\Scripts"
error_log = iis_gtc + "\\AtualizaBanco\\erro_Banco.txt"

execute 'Copy Scripts files' do
  command "robocopy #{orig} #{dest} /s /COPY:DT"
  returns [0,1,3]
end


execute 'exec atualizabanco' do
  command "#{iis_gtc}\\AtualizaBanco\\Atualizabanco.exe AUTO NOMESSAGES"
end

ruby_block "Results" do
    only_if { ::File.exists?(error_log) }
    block do
        print "Erro ao Atualizar Banco!!! Checar manualmente.\n"
    end
end
