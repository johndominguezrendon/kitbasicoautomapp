#!/bin/bash
cd KitBasicoAutomApp
gradle -Dflyway.configFiles=../DefaultFlywayConfig.config flywayRepair flywayMigrate
