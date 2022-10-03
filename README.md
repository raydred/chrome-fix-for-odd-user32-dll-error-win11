# chrome-fix-for-odd-user32-dll-error-win11
My powershell script solution for a weird error that prevented chrome to run on windows 11. (probably 10 as well)

**Let me explain...**
---

##The problem
---
I recognize that Windows (11,10) is a very complex system. With that said, **IT SUCKS! WINDOWS TOTALLY SUCK!** Now that I got that out of the way, I'll continue to the issue at hand...

For some reason, a month or 2 after I upgraded to Windows 11, my Chrome stopped working. It was bizarre, it's still bizarre. I can't remember when it stopped, but MONTHS ago, it stopped working. I switched to firefox until the same thing happened. At that point, I needed my Chrome browser back. I did the following :

- Googled solutions
- Tried a bunch of solutions
- uninstalled chrome a hyberbolic amount of times
- reinstalled chrome a hyberbolic amount of times
- Event log research
- Tried a bunch more solutions
- uninstalled chrome a hyberbolic amount of times, again
- reinstalled chrome a hyberbolic amount of times, again
- gave up
- got back in!
- decided to fix it.

##Get to the point!
---
Ok fine! So what I've been able to gather is, User32.dll is causing a fault with Chrome and won't allow it to launch for whatever reason. I'm not a windows programmer, so I'm at a loss to understand the nuances of the error. 

However, if you rename the ==chrome.exe== binary, to something else, it would work. 
But here's the issue *that* caused.

If you wanted chrome to update, it would fail. and get all weird. So I had a brilliant IDEA! If you copy the binary, with an underscore preceding the name, then create a symbolic link of "chrome.exe" ==> "_chrome.exe", then the update works, everthing works, until the browser gets updated again...

##But that's what this script is for! 
---
This powershell script has been made to make the "fixing" process easy with one click.
I even have an idea that if I can find the event ID that launches when chrome is finished updating, maybe I can just use windows task man to listen for that trigger and run this fix script so that next time I boot my laptop up, it just fixes it. I'm not there yet, but I'll keep you updated!


**##Prerequisites**
---
