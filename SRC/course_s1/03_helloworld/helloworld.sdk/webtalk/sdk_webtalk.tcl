webtalk_init -webtalk_dir E:\\AX7010\\labs\\helloworld\\helloworld.sdk\\webtalk
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "����һ ʮ�� 24 20:08:44 2016" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "SDK v2015.4" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2015.4" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "amd64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "SDK" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "false" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "l0em9fmtstpn7f1b3koil1ccos" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "2015.4_2" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "2" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "" -context "user_environment"
webtalk_add_data -client project -key os_release -value "" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "" -context "user_environment"
webtalk_register_client -client sdk
webtalk_add_data -client sdk -key uid -value "1477310363797" -context "sdk\\\\hardware/1477310363797"
webtalk_add_data -client sdk -key isZynq -value "true" -context "sdk\\\\hardware/1477310363797"
webtalk_add_data -client sdk -key Processors -value "2" -context "sdk\\\\hardware/1477310363797"
webtalk_add_data -client sdk -key VivadoVersion -value "2015.4" -context "sdk\\\\hardware/1477310363797"
webtalk_add_data -client sdk -key Arch -value "zynq" -context "sdk\\\\hardware/1477310363797"
webtalk_add_data -client sdk -key Device -value "7z010" -context "sdk\\\\hardware/1477310363797"
webtalk_add_data -client sdk -key IsHandoff -value "true" -context "sdk\\\\hardware/1477310363797"
webtalk_add_data -client sdk -key uid -value "1477310407323" -context "sdk\\\\bsp/1477310407323"
webtalk_add_data -client sdk -key hwid -value "1477310363797" -context "sdk\\\\bsp/1477310407323"
webtalk_add_data -client sdk -key os -value "standalone" -context "sdk\\\\bsp/1477310407323"
webtalk_add_data -client sdk -key apptemplate -value "hello_world" -context "sdk\\\\bsp/1477310407323"
webtalk_add_data -client sdk -key uid -value "1477310409841" -context "sdk\\\\application/1477310409841"
webtalk_add_data -client sdk -key hwid -value "1477310363797" -context "sdk\\\\application/1477310409841"
webtalk_add_data -client sdk -key bspid -value "1477310407323" -context "sdk\\\\application/1477310409841"
webtalk_add_data -client sdk -key newbsp -value "true" -context "sdk\\\\application/1477310409841"
webtalk_add_data -client sdk -key os -value "standalone" -context "sdk\\\\application/1477310409841"
webtalk_add_data -client sdk -key apptemplate -value "hello_world" -context "sdk\\\\application/1477310409841"
webtalk_transmit -clientid 1336631409 -regid "" -xml E:\\AX7010\\labs\\helloworld\\helloworld.sdk\\webtalk\\usage_statistics_ext_sdk.xml -html E:\\AX7010\\labs\\helloworld\\helloworld.sdk\\webtalk\\usage_statistics_ext_sdk.html -wdm E:\\AX7010\\labs\\helloworld\\helloworld.sdk\\webtalk\\sdk_webtalk.wdm -intro "<H3>SDK Usage Report</H3><BR>"
webtalk_terminate