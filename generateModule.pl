#!/usr/bin/perl
# **************************************************************************** #
#                                                                              #
#                                                         ::::::   ::::::      #
#    gen.pl                                              :+:+:       :+:       #
#                                                       +:+ +:+     +:+        #
#    By: nickaroot <nickaroot.me>                      +:+   +:+   +:+         #
#                                                     +#+     +#+ +#+          #
#    Created: 2019/05/20 03:54:02 by nickaroot       #+#       #+#+#           #
#    Updated: 2019/05/20 04:47:37 by nickaroot      ####       ####.me         #
#                                                                              #
# **************************************************************************** #

use strict;
use warnings;
use POSIX qw(strftime);

main();

sub main {

	if ($#ARGV < 0) {
		
		my $usage = "usage: ./gen.pl <ModulePrefix> [<ProjectName>] [<DeveloperName>]\n\nex.: ./gen.pl SM ViperProject Craig Frederighi";

		print $usage;

		exit;

	}

	if ($ARGV[0] eq "clean") {

		exec "rm -rf Configurator Constants Interactor Nodes Presenter Router View";

	}

	my $shortName = $ARGV[0];
	my $projectName = defined $ARGV[1] ? $ARGV[1] : "ViperProject";
	my $developerName = defined $ARGV[2] ? $ARGV[2] : "Craig Frederighi";
	my $date = strftime "%m/%d/%Y", localtime;
	my $year = strftime "%Y", localtime;

	configurator($shortName, $projectName, $developerName);
	constants($shortName, $projectName, $developerName);
	interactor($shortName, $projectName, $developerName);
	nodes($shortName, $projectName, $developerName);
	presenter($shortName, $projectName, $developerName);
	router($shortName, $projectName, $developerName);
	view($shortName, $projectName, $developerName);

}

sub sourceHeader($$$) {

	my ($moduleFileName, $projectName, $developerName) = @_;
	my $date = strftime "%m/%d/%Y", localtime;
	my $year = strftime "%Y", localtime;
	
	my $header =

"//
//  ${moduleFileName}
//  ${projectName}
//
//  Created by ${developerName} on ${date}.
//  Copyright © ${year} ${developerName}. All rights reserved.
//";

return $header;

}

sub createSource($$$$) {

	my ($path, $fileName, $source, $isMainFile) = @_;

	if ($isMainFile) {

		die "Unable to create $path\n" unless(mkdir $path);

	}

	die "Unable to create $path/$fileName\n" unless(open SOURCEFILE, ">$path/$fileName");

	print SOURCEFILE $source;

	close SOURCEFILE;

}

sub configurator($$$) {

	my ($shortName, $projectName, $developerName) = @_;

	my $moduleName = "Configurator";
	my $moduleFullName = "${shortName}${moduleName}";
	my $modulePath = "${moduleName}";
	my $moduleFileName = "${moduleFullName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"import UIKit

protocol ${moduleFullName}Protocol: class {
  
  static func configure(with view: ${shortName}View, navigation: UINavigationController?)
  
}

class ${moduleFullName}: ${moduleFullName}Protocol {
  
  static func configure(with view: ${shortName}View, navigation: UINavigationController?) {
    
    let presenter = ${shortName}Presenter()
    let interactor = ${shortName}Interactor()
    let router = ${shortName}Router(navigation: navigation)
    
    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
  }
  
}";

	my $moduleSource = 

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 1);

}

sub constants($$$) {

	my ($shortName, $projectName, $developerName) = @_;

	my $moduleName = "Constants";
	my $moduleFullName = "${shortName}${moduleName}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleFullName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"class ${moduleFullName} { }";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 1);

}

sub interactor($$$) {

	my ($shortName, $projectName, $developerName) = @_;

	my $moduleName = "Interactor";
	my $moduleFullName = "${shortName}${moduleName}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleFullName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"class ${moduleFullName} {
  
  weak var presenter: ${moduleFullName}Output!
  
}";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 1);

	interactorInput($shortName, $projectName, $developerName, $moduleName);
	interactorOutput($shortName, $projectName, $developerName, $moduleName);

}

sub interactorInput($$$$) {

	my ($shortName, $projectName, $developerName, $moduleName) = @_;

	my $moduleFullName = "${shortName}${moduleName}";
	my $moduleSuffix = "Input";
	my $moduleSuffixName = "${moduleFullName}${moduleSuffix}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleSuffixName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"protocol ${moduleSuffixName}: class { }

extension ${moduleFullName}: ${moduleSuffixName} { }";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 0);

}

sub interactorOutput($$$$) {

	my ($shortName, $projectName, $developerName, $moduleName) = @_;

	my $moduleFullName = "${shortName}${moduleName}";
	my $moduleSuffix = "Output";
	my $moduleSuffixName = "${moduleFullName}${moduleSuffix}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleSuffixName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"protocol ${moduleSuffixName}: class { }";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 0);

}

sub nodes($$$) {

	my ($shortName, $projectName, $developerName) = @_;

	my $modulePath = "Nodes";

	mainNode($shortName, $projectName, $developerName, $modulePath);

}

sub mainNode($$$$) {

	my ($shortName, $projectName, $developerName, $modulePath) = @_;

	my $moduleName = "MainNode";
	my $moduleFullName = "${shortName}${moduleName}";
	my $moduleFileName = "${moduleFullName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"import AsyncDisplayKit
import RFUI

public class ${moduleFullName}: RFMainNode {
  
  required init() {
    
    super.init()
    
    automaticallyManagesSubnodes = true
    
  }
  
  public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
    let verticalStack = RFVerticalStack()
    
    return ASInsetLayoutSpec(insets: insets, child: verticalStack)
    
  }
  
}

extension ${moduleFullName} { }";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 1);

}

sub presenter($$$) {

	my ($shortName, $projectName, $developerName) = @_;

	my $moduleName = "Presenter";
	my $moduleFullName = "${shortName}${moduleName}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleFullName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"import AsyncDisplayKit
import RFUI
import RFCartService

class ${moduleFullName}: ${moduleFullName}Input {
  
  weak var view: ${shortName}ViewInput!
  var router: ${shortName}RouterInput!
  var interactor: ${shortName}InteractorInput!
  
  func configureView() {
    
    view.node.insets = UIEdgeInsets(
      top: UIApplication.shared.statusBarFrame.height,
      left: 0,
      bottom: 0,
      right: 0
    )
    
    view.node.setNeedsLayout()
    
  }
  
  func showView() {
    
    view.setTitle(\" \")
    
    view.hideNavbar()
    
  }
  
  func hideView() {
    
    view.setTitle(\" \")
    
  }
  
}";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 1);

	presenterInput($shortName, $projectName, $developerName, $moduleName);
	presenter_interactorOutput($shortName, $projectName, $developerName, $moduleName);
	presenter_viewOutput($shortName, $projectName, $developerName, $moduleName);

}

sub presenterInput($$$$) {

	my ($shortName, $projectName, $developerName, $moduleName) = @_;

	my $moduleFullName = "${shortName}${moduleName}";
	my $moduleSuffix = "Input";
	my $moduleSuffixName = "${moduleFullName}${moduleSuffix}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleSuffixName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"protocol ${moduleSuffixName}: class {
  
  func configureView()
  
  func showView()
  
  func hideView()
  
}";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 0);

}

sub presenter_interactorOutput($$$$) {

	my ($shortName, $projectName, $developerName, $moduleName) = @_;

	my $moduleFullName = "${shortName}${moduleName}";
	my $moduleExtension = "InteractorOutput";
	my $moduleExtensionName = "${shortName}${moduleExtension}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleFullName}+${moduleExtensionName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"extension ${moduleFullName}: ${moduleExtensionName} { }";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 0);

}

sub presenter_viewOutput($$$$) {

	my ($shortName, $projectName, $developerName, $moduleName) = @_;

	my $moduleFullName = "${shortName}${moduleName}";
	my $moduleExtension = "ViewOutput";
	my $moduleExtensionName = "${shortName}${moduleExtension}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleFullName}+${moduleExtensionName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"extension ${moduleFullName}: ${moduleExtensionName} {
  
  func didLoad() {
    
    configureView()
    
  }
  
  func willAppear(_ animated: Bool) {
    
    showView()
    
  }
  
  func willDisappear(_ animated: Bool) {
    
    hideView()
    
  }
  
}";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 0);

}

sub router($$$) {

	my ($shortName, $projectName, $developerName) = @_;

	my $moduleName = "Router";
	my $moduleFullName = "${shortName}${moduleName}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleFullName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"import UIKit

protocol ${moduleFullName}Input: class {
  
}

class ${moduleFullName}: ${moduleFullName}Input {
  
  weak var navigation: UINavigationController?
  
  init(navigation: UINavigationController?) {
    
    self.navigation = navigation
    
  }
  
}";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 1);

}

sub view($$$) {

	my ($shortName, $projectName, $developerName) = @_;

	my $moduleName = "View";
	my $moduleFullName = "${shortName}${moduleName}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleFullName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"import AsyncDisplayKit

public class ${moduleFullName}: ASViewController<${shortName}MainNode> {
  
  var presenter: ${moduleFullName}Output!
  
  public init() {
    
    super.init(node: ${shortName}MainNode())
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    
    fatalError(\"init(coder:) not implemented\")
    
  }
  
  override public func viewDidLoad() {
    
    super.viewDidLoad()
    
    ${shortName}Configurator.configure(with: self, navigation: navigation)
    
    presenter.didLoad()
    
  }
  
  override public func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    presenter.willAppear(animated)
    
  }
  
  override public func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    
    presenter.willDisappear(animated)
    
  }
  
}";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 1);
	
	viewInput($shortName, $projectName, $developerName, $moduleName);
	viewOutput($shortName, $projectName, $developerName, $moduleName);

}

sub viewInput($$$$) {

	my ($shortName, $projectName, $developerName, $moduleName) = @_;

	my $moduleFullName = "${shortName}${moduleName}";
	my $moduleSuffix = "Input";
	my $moduleSuffixName = "${moduleFullName}${moduleSuffix}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleSuffixName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"import AsyncDisplayKit

protocol ${moduleSuffixName}: class {
  
  var presenter: ${moduleFullName}Output! { get set }
  
  var navigation: UINavigationController? { get }
  var tabBarController: UITabBarController? { get }
  
  var node: ${shortName}MainNode! { get }
  
  var frame: CGRect { get set }
  
  func setTitle(_ title: String)
  
  func hideNavbar()
  
}

extension ${moduleFullName}: ${moduleSuffixName} {
  
  var navigation: UINavigationController? { return navigationController }
  
  var frame: CGRect { get { return view.frame } set { view.frame = newValue } }
  
  func setTitle(_ title: String) {
    
    self.title = title
    
  }
  
  func hideNavbar() {
    
    guard let navigation = navigation else { return }
    
    navigation.navigationBar.isHidden = true // TODO
    
  }
  
}";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 0);

}

sub viewOutput($$$$) {

	my ($shortName, $projectName, $developerName, $moduleName) = @_;

	my $moduleFullName = "${shortName}${moduleName}";
	my $moduleSuffix = "Output";
	my $moduleSuffixName = "${moduleFullName}${moduleSuffix}";
	my $modulePath = $moduleName;
	my $moduleFileName = "${moduleSuffixName}.swift";

	my $moduleHeader = sourceHeader($moduleFileName, $projectName, $developerName);

	my $moduleBody =

"protocol ${moduleSuffixName}: class {
  
  func didLoad()
  
  func willAppear(_ animated: Bool)
  
  func willDisappear(_ animated: Bool)
  
}";

	my $moduleSource =

"${moduleHeader}

${moduleBody}
";

	createSource($modulePath, $moduleFileName, $moduleSource, 0);

}
