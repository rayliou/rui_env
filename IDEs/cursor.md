
## Cursor:Azure Account timeout, cannot use Azure plugins
- https://github.com/getcursor/cursor/issues/1648
This seems to be the solution: microsoft/vscode-azure-account#897 (comment)

Found the fix elsewhere. https://forum.cursor.com/t/azure-extension-doesent-work/3949/15

Fix Azure extensions on Cursor Cursor does not come with Microsoft authentication, a builtin extension for vscode

To get this extension, grab it from VSCode \AppData\Local\Programs\Microsoft VS Code\resources\app\extensions\microsoft-authentication Copy to \AppData\Local\Programs\cursor\resources\app\extensions

For MacOS

/Applications/Visual Studio Code. app/Contents/Resources/app/extensions/microsoft-authentication and /Applications/Cursor.app/Contents/Resources/app/extensions

Reload Cursor windows after.

See additional steps at the link to connect to servers.

@PaulBernhardt

