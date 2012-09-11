maintainer       "Phillip Goldenburg"
maintainer_email "phillip.goldenburg@sailpoint.com"
license          "Apache 2.0"
description      "Installs/Runs unattended-upgrades"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
recipe            "unattended-upgrades", "Runs unattened-upgrade if apt-get update periodic has run recently."

%w{ apt }.each do |cb|
  depends cb
end

%w{ ubuntu debian }.each do |os|
  supports os
end
