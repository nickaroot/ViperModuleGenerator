# Generate Sample Viper Module with Perl Script

## Quick Start

`git clone https://github.com/nickaroot/ViperModuleGenerator`
`cd ViperModuleGenerator`
`./generateModule.pl SM`

## Generate

`./generateModule.pl <ModulePrefix> [<ProjectName>] [<DeveloperName>]`

### Nodule Prefix

`./generateModule.pl SM`

Generates _*SM*Configurator.swift_, _*SM*View.swift_, etc.

### Project Name

`./generateModule.pl SM ViperProject`

Sets _ViperProject_ in files headers

### Developer Name

`./generateModule.pl SM ViperProject "Craig Frederighi"`

Sets _Craig Frederighi_ in files headers

## Clean

**This command will clean _all_ Viper files in the directory**

`./generateModule.pl clean`
