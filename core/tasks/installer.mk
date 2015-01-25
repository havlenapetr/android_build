# Copyright (C) 2014 Havlena Petr <havlenapetr@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Android makefile to build installer for odroidu

TARGET_INSTALLER_DIR := $(PRODUCT_OUT)/installer
$(TARGET_INSTALLER_DIR):
	$(hide) rm -rf $(TARGET_INSTALLER_DIR)
	$(hide) mkdir -p $(TARGET_INSTALLER_DIR)

TARGET_INSTALLER_ZIP := $(PRODUCT_OUT)/$(name)-installer.zip
$(TARGET_INSTALLER_ZIP): $(BUILT_TARGET_FILES_PACKAGE) $(DISTTOOLS) $(TARGET_INSTALLER_DIR)
	@echo ----- Making odroidu installer ------
	$(hide) cp -R $(PRODUCT_OUT)/bootloader/* $(TARGET_INSTALLER_DIR)
	$(hide) cp $(PRODUCT_OUT)/kernel $(TARGET_INSTALLER_DIR)
	$(hide) split -b16m $(INSTALLED_SYSTEMIMAGE) $(TARGET_INSTALLER_DIR)/system_
	$(hide) split -b16m $(BUILT_CACHEIMAGE_TARGET) $(TARGET_INSTALLER_DIR)/userdata_
	$(hide) split -b16m $(BUILT_USERDATAIMAGE_TARGET) $(TARGET_INSTALLER_DIR)/userdata_
	$(hide) zip -rj $(TARGET_INSTALLER_ZIP) $(TARGET_INSTALLER_DIR)

.PHONY: installer
installer: $(TARGET_INSTALLER_ZIP)