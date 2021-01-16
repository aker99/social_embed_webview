## [0.3.0] - Bug Fix:
* Bug Fix
    * Instagram height adjust issue fix

## [0.3.0] - Bug Fix: 2020-12-12.
* **Added Suport** of Facebook Video/Post
* Bug Fix
    * Extra margin inside webview removed (*Resulting increase width of embed by 14px*)
    * Jitter in webview background-color removed

## [0.3.0-dev.4] - Refactoring, Bug Fix and Dependencies update: 2020-12-11.
* Breaking Changes (**Not backward compatiable**)
* Bug Fix
    * Webview auto dispose (Fixed by *webview_flutter*)
    * Closing media content on widget dispose (Fixed by *webview_flutter*)
    * Pausing/Stop media content on Widget State Change (limited to *Youtube Embed*)
* **Remove Suport** of Facebook Video/Post (*Comming back soon*)
* Dependencies Verion Update
    * webview_flutter: *0.3.22+1* -> *1.0.7*
    * url_launcher: *5.5.1* -> *5.7.10*

## [0.2.5] - Bug Fix: 2020-09-02.
* Features
    * OnClick *native Open-In* option added
    * Define Background Color of Widgets (default: `scaffoldBackgroundColor`)
* Bug Fix
    * Insatgram embed picture would be visible now
    * Minor bottom clipping removed
    * Extract console statements removed 

## [0.2.3] - Platfrom Added: 2020-08-14.
* Added support of:
    * Facebook Post
    * Facebook Video
* Youtube Bug Fix:
    * Video size ratio set to *16:9*
    * Input data changed from *embed code* to *youtube video id*

## [0.2.1] - Initial Release: 2020-08-13.
* Added support of: 
    * Youtube
    * Instagram 
    * Twitter
