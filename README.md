# Mac-Sync
Shell scripts for managing photos library across hosts

These shell scripts are some that I use across several Mac and Linux machines in order to backup and to sync Photos (iPhoto, Aperterure) library.

The scripts will typically not work for someone else without editing them first AND there is a dependency on installing and configuring rsync on the mac machines.   They are potentially interesting for others with similar goals in that they show (i.e. save research time determining howto) wake up another mac machine, wait for it to become ready, and then attach and sync using `rsync`.  The good news is that `rsync` has the capability to work with the HFS filesystems used by mac os.   

The problem that this script solves is sharing a common iPhoto (now Photos) library across two machines: my machine and my wife's.  The model here is that I do all the imports, edits, and organization on my mac, and then snync that with my wife's mac so that she can see, play slideshows, and make use of the photos for her emails, letters, etc.   Note that all the sync is in one direction.   Once our photos library got large, I also looked at this as a way to make backups.  And finally, when I set up a home media server, it also became a way to publish the photos to that (Ubuntu) machine.

I originally developed these when rsync 3.1.1 was current, and compiled and installed that version on my macs.  I've simply used the current rsync version on linux for those machines.   You should use an rsync 3.1.3 or newer to maintain security.  I don't remember why, but I could not make use of the rsync 2.6.9 that came bundled with mac os.  I run rsync as a daemon on both the linux server and my wife's mac.

The sync includes resource fork data. This works perfectly mac-to-mac and for the most part with the linux rsync server, but it will fail when the resource fork is large, and I've had trouble with some photo editing software putting thumbnails of the photo into its resource fork.  It did not affect the overall system or integrity of Photos, but in order to stop seeing the slew of errors, I made another script that will search a directory and systematically remove resource forks.  This tool works well for me, but beware, it can be dangerous if you do not know what you're doing or take care where you run it.  (think about the way you need to be careful when typing `rm -rf` )

## SyncPhotos

this script backs up or forces sync from the authoratative source to the ones I want to make mirror images.

Usage:  `SyncPhotos imac | supermicro | backup [ backup-drive]`

So it will do one of three things:

**imac** - will wake up my wife's machine and rsync the photos library there.

**supermicro** - will rsync to a linux server that is always running and awake

**backup** - it will look for my typical backup drive (named ) `LaCie` unless I append another drive name afterward, in which case it will backup there.


## RestorePhotos

This script is less refined (it won't wake up my wife's mac) and is mostly about remembering which commands can restore a corrupted or messed up library from one of the places it was synced to before.  I've rarely (only once) used this tool, so it is not as sophisticated as the first one.  It does not restore from an arbitrary drive.

Usage: `RestorePhotos imac | supermicro | backup`

## rm-rsrc.sh

This script will hunt down resource forks and remove them.  

Usage: `rm-rsrc.sh [-hv --help --verbose] pix | directory-to-remove-forks`

if you give no arguments or the help argument it show the  usage line.  I hardcoded "pix" to work with my photos library, but alternately, you can give it a directory as an argument instead of pix and it work from there instead.

If you add the argument to be verbose then it tells you each file from which it removes a resource fork.

