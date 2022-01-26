# isolate_2way

2 Way isolate demo in Flutter

## Requirement Statement

A solution is required in Flutter or Dart to send and receive message between the parent and child isolate process.

## Solution

In this project the main process interacts with the child isolate. 

* User enters a text in the textfield on the UI
* User clicks on the **To Uppercase** button
* Main process sends the input to the child isolate
* Child isolate converts text to upper case
* Child Isolate send the converted text back to Main process
* Main process invoked the handler, this case it is the Home Page
* Home Page shows the converted text on the screen

