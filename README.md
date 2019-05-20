# Generate Sample Viper Module with Perl Script

## Quick Start

`git clone https://github.com/nickaroot/ViperModuleGenerator`

`cd ViperModuleGenerator`

`./generateModule.pl SM`

## Generate

`./generateModule.pl <ModulePrefix> [<ProjectName>] [<DeveloperName>]`

### Module Prefix

`./generateModule.pl SM`

Generates **SM**Configurator.swift, **SM**View.swift, etc.

### Project Name

`./generateModule.pl VP ViperProject`

Sets **ViperProject** in files headers

### Developer Name

`./generateModule.pl VP ViperProject "Craig Frederighi"`

Sets **Craig Frederighi** in files headers

## Clean

**This command will clean _all_ Viper files in the directory**

`./generateModule.pl clean`
