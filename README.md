# DelphiUIAutomation
Delphi classes that wrap the MS UIAutomation library.

DelphiUIAutomation is a framework for automating rich client applications based on Win32 (and specifically tested with Delphi XE5). It is written in Delphi XE5 and it requires no use of scripting languages.

Tests and automation programs using DelphiUIAutomation can be written with Delphi and used in any testing framework available to Delphi.

It provides a consistent object-oriented API, hiding the complexity of Microsoft's UIAutomation library and windows messages.

## Getting started

The DelphiUIAutomation library is a wrapper for the UIAutomationClient library, which has been extracted into the UIAutomationClient_TLB source file. As the generated code is large and complex, this has been wrapped up in a number of units, each providing classes that encapsulate part of this library (together with other utility methods).

### Launching an application

The TAutomationApplication class provides functionality to start and attach to an application. There are 3 class methods provided to do this.

* Launch - this will launch the application supplied, and pass in any supplied arguments
* Attach - this will attach to an already launched application, based on the executable name
* LaunchOrAttach - this will either attach to an already launched application, or launch the application.

The snippet below will check whether the Project1.exe is running, and attach if it is, or it will start the application, and then attach to it.

```pascal
Application := TAutomationApplication.LaunchOrAttach(
      'democlient\Win32\Debug\Project1.exe',
      ''
```

When attached to an application, it is possible to call further methods on it

* Kill - Will kill the process associated with the application
* WaitWhileBusy - Waits for the application to be idle, this has an optional timeout (in milliseconds) associated with it
* SaveScreenshot - Takes a screenshot of the application, and then saves this to a file.

### Getting hold of a window

To get a 'desktop' window (i.e. one that appears in the Windows tasks bar), then the TAutomationDesktop class provides a class function that returns a TAutomationWindow object.

```pascal
var
  notepad : IAutomationWindow;
  ...
  
  notepad := TAutomationDesktop.GetDesktopWindow('Untitled - Notepad');
  notepad.Focus;
```

This will find (it is there) a window that has the given title, and set focus to it. This window is independant of the overalll application, and might not even be associated with the same application that is being automated.

To get an 'application' window, i.e. one associated with another window, first the parent window must be found, and then the target child can be found using the ''Window'' method. In the example below, the child window 'Security' of the notepad window is searched for.

```pascal
var
  security : IAutomationWindow
  ...
  
  security := notepad.Window('Security');
```

### Finding a control

Each control contained in a window can be identified by the index of that control OR sometimes (this depends on the control type) by the text associated with it. For example, in order to get the textbox associated with the connection window (and assuming that it is the 1st Edit box on the window), the following code will find the editbox, and change the text to be USER1.

```pascal
var
  user : IAutomationEditBox;

  user := connect.GetEditBoxByIndex(0);
  user.Text := 'USER1';
```

### Invoking actions on controls

In order to click the 'OK' button associated with the connection window, it can be found by the text associated with the button, the following code will find the button, and call the click event.

```pascal
var
  btnOK : IAutomationButton;
  ...
  
  btnOK := connect.GetButton('OK');
  btnOk.Click;
```

# Contributors
Mark Humphreys

# License
Apache Version 2.0 Copyright (C) 2015

See license.txt for details.

# See also
* [Microsoft Accessibility](https://msdn.microsoft.com/en-us/library/vstudio/ms753388(v=vs.100).aspx)
* [UIAutomation for Powershell](http://uiautomation.codeplex.com/documentation)
* [TestStack.White](https://github.com/TestStack/White)
* [UI Automation - A wrapper around Microsoft's UI Automation libraries.](https://github.com/vijayakumarsuraj/UIAutomation)

