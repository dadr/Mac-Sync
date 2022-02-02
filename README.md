# Mac-Sync
Shell scripts for managing photos library across hosts

These shell scripts are some that I use across several Mac and Linux machines in order to backup and to sync Photos (iPhoto, Aperterure) library.

The scripts will typically not work for someone else without editing them first AND there is a dependency on installing and configuring rsync on the machines.   They are potentially interesting for others with similar goals in that they show (or save research time determining howto) wake up another mac machine, wait for it to become ready, and then attach and sync.   

The problem that this script solves is sharing a common iPhoto (now Photos) library across two machines.  My machine and my wife's.  The model here is not for a 2-way sync, but rahter that I do all the imports, edits, and organization on my computer, and then share that with my wife's computer so that she can see, play slideshows, and make use of the photos for her emails, letters, etc.   So all the sync is in one direction.   Once our photos library got large, I also looked at this as a way to make backups.  And finally, when I set up a home media server, it also became a way to publish the photos to that (Ubuntu) machine.

I originally developed these when rsync 3.1.1 was current, and compiled and installed that version on my macs.  I've simply used the current rsync version on linux for those machines.   You should use an rsync 3.1.3 or newer to maintain security.  I don't remember why, but I could not make use of the rsync 2.6.9 that came bundled with mac os.  I run rsync as a daemon on both the linux server and my wife's mac.

The sync includes resource fork data, and this works for the most part with the linux rsync server, but it will fail when the resource fork is large, and I've had trouble with some photo editing software putting thumbnails of the photo into its resource fork.  It did not affect the overall system, but in order to stop seeing the slew of errors, I made another script that will search a directory and systematically remove resource forks.  This tool works well for me, but beware, it can be dangerous if you do not know what you're doing it to.  (think about the way you need to be careful when typing `rm -rf` )

## SyncPhotos

this script backs up or forces sync from the authoratative source to the ones I want to make mirror images.

usage:  SyncPhotos imac | supermicro | backup [ backup-drive]

So it will do one of three things:

**imac** - will wake up my wife's machine and rsync the photos library there.
**supermicro** - will rsync to a linux server that is always running and awake
**backup** - it will look for my typical backup drive (named ) `LaCie` unless I append another drive name afterward, in which case it will backup there.


## RestorePhotos

this script is less refined (it won't wake up my wife's mac) and is mostly about remembering which commands can restore a corrupted or messed up library from one of the places it was synced to before

## rm-rsrc.sh

this script will hunt down resource forks and remove them  

usage: rm-rsrc.sh [ [-h | --help] | [-v |  --verbose] ["pix" | dir]

if you give no arguments it will run from the current directory.  I hardcoded "pix" to work with my photos library, and you can give it a directory as an argument instead of pix and it will look there instead.

If you add the argument to be verbose then it tell you each file it found with a resource fork.

