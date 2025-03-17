# AIInAAL
AIInAAL - pronounced (ān-ᵊl) or 'anal' in English...fun acronym for AI-IntelArc-ArchLinux. It is a framework for installing and running popular AI software on Arch Linux using Intel Arc GPUs.

# How You Can Support Development  

[<img align="left" width="20%" src="https://media.giphy.com/media/hXMGQqJFlIQMOjpsKC/giphy.gif">](https://bmc.link/OCD_Insomniac)  

*    Please consider supporting me with [Buy Me A Coffee](https://bmc.link/OCD_Insomniac)!
*    Get the buzz out by reviewing and sharing on social networks like Facebook, Twitter (formerly), etc...
*    Consider purchasing something from the [Amazon wishlist](https://www.amazon.com/hz/wishlist/ls/25OBUY6VTN1C8?ref_=wl_share)...items I always need more of. (Mouses, Keyboards, Storage, etc...)
*    [<img align="left" width="10%" src="https://m.media-amazon.com/images/I/41CMZ4XoAJL._SS135_.jpg">](https://www.amazon.com/hz/wishlist/ls/25OBUY6VTN1C8?ref_=wl_share)
<br clear="left"/>

# What's Currently Working (3/17/2025)
*   ComfyUI
     - Installs and works as it should. Tied to the shared folder like all other packages working in AIInAAL, so make sure you have one.
     - The shared1 folder is provided as a structure template, so if you don't have a "shared" folder, just rename it by removing the 1 at the end.
     - I have noticed that some node packages require tensorflow or onnxruntime. Be cautious what you install. Look at the package requirements.txt file.
          Some custom nodes packages can break your install since they will try to install packages through pip.

*   OmniGen (WIP but generating images)
     -TODO:  Shared folder links
             Initial model download is 15GB+ - Test smaller models
*   F5-TTS
     - Installs and runs. I have been able to generate a reference voice file and then create speech in the cloned voice.
     - The initial tests prove...well, less than I had hoped for. The end result seems choppy...speed is too fast. Can't say certain
       words...etc. Perhaps it's my reference. I dunno... It installs and works so give it a whirl if you like, but I'd keep expectations low-ish.

# Recently jacked up...(3/17/2025)

     Farily recent update to Intel extensions for pytorch has created a problem with GLIBC 2.41...apparently. SEE: https://github.com/intel/intel-extension-for-pytorch/issues/794 . I would say this is Arch specific, but it seems to be affecting any distro dependent on GLIBC 2.41
          For now, we'll need to wait for a fix. It seems that several packages have been effected. Evident if you see this error: "ImportError: libintel-ext-pt-cpu.so: cannot enable executable stack as shared object requires: Invalid argument"
*   Fooocus
*   DeFooocus
*   Ollama + OpenWebUI
*   Forge

Remember that there are limitations beyond my control...like memory management, for example. AIInAAL is a framework for these packages to be installed, but ultimately, these versions, while more versitile and convenient, are the original programs at their core. I've done my best to get them to work with Intel Arc dGPUs on Arch, but this entire project is always a WIP. Keep that in mind before you try to flame me if using something you got for free misbehaves...

# Recent Notes from JT/OCD
     *  3/17/2025
          I'm getting urked.  I was making such great progress on getting these packages working...now this GLIBC issue. It stands to reason that might also
               be contributing to the issues with Ollama too.  Fortunately, Ollama will still run using the CPU, but I'm still counting it as broken for my
               purposes...at least for now. I'm going to have a look at the "portable" version that the IPEX team has released and see if I can incorporate
               it into AIInAAL as possibly a more convenient way to keep it working in AIInAAL.  I would just rather have more control over the environment
               packages. I'm not a huge fan of docker and prefer using python environments since it's easier to see what's going on with it as well as easily
               accessing files for modification.  I'm pretty sure I saw a docker version on github not long ago...but like I said, I'll have a look.  Also, I
               saw an ollama-vulkan package...or something like that. It is just what you'd think...ollama built to utilize Vulkan. In theory, that might also
               work for our Intel GPUs...in theory. I know that Intel is still lagging behind regarding support in Vulkan, but there may be enough support there
               to allow that version of ollama to function. I dunno...need to check it out.
          It seems that our list of working packages for AIInAAL is dwindling...I'll keep chipping away at it though.  I'd really like to see Intel climb the
               popularity ladder...but that will only come with functionality and in the AI realm, progress is slow...and THAT is a sales-killer. I'm seeing so many "improvements" that they are making that don't even apply to the Arc GPUs. This having to split the updates into a specific order is irritating too. You'd think since the Intel PyTorch team and the Intel Extensions team both are working towar the same thing and one is directly dependent on the other, they could get on the same page. I mentioned the version issues below...but seriously..one little character would've handled it. Change == to <= to kill this flippin RED TEXT, constant overwriting BS.  I'm ranting...like I said...I'm urked.  I'd change it, but that's included in their wheel dependencies, right?  Ugh...
     *  3/13/2025
          The Intel Extensions for Pytorch team released v 2.6.10+xpu and also changed the download location for the Intel version of PyTorch. I've made the
               adjustments in AIInAAL. They also failed to correctly specify the version for a package requirement resulting in errors. I have split the
               install/updates so that the correct version of the compiler is updated just before launching the apps. I've included the torch packages in the package reqs and the Intel Extensions in the intel_reqs. The update process must remain a 2-stage process until the Intel Extensions team gets their act together and points the extenstions to the right version. If you see errors regarding conflicts between versions 2025.0.2 and 2025.0.4, that's what this is. Spliting the updates this way ensures functionality even though the errors are spit out. So ignore the red text for now.
          OLLAMA - Okay...for some reason, OpenWebUI only seems to send reqs to the Ollama server to use the CPU. At least, that's what it seems like
               to me. Inference is SLOOOOOOW when done through OpenWebUI. Ironically, when ollama is used directly through the terminal, the speeds are pretty
               good with a 20B parameter (~12GB) LLM (in my testing).  I'm looking for a replacement frontend I like as a backup/alternative to OpenWebUI.
     *  2/5/25
          I noticed today that GitHub has blocked remote access (ban/block) to C0untFloyd's RoopUL repository and every other fork of it for that matter.  Simply, that means my installer and modification scripts won't 
               work through the original GitHub repository since the base program can't be downloaded...at least, not from GitHub.  That is to say, there's other places to find the archived package if you live in a place
               that allows for it.
          I have removed RoopUL from the "What's Working" list above accordingly. I don't want to step on anyone's toes.  It's funny that just last month I noted that I was looking for a replacement. Now, it seems, I
               have to...so I'll be looking at that too.  Too bad about RoopUL. It was a fun toy to mess around with.
          I have Ollama listed above, but I realized that I had installed Ollama to my root rather than in the AIInAAL environment.  That explains why it was working well even though I had seen posts stating that GPUs were
               not usable in (docker) containers. I've been working on getting it to work within the AIInAAL container, and I've gotten it to install and run...but it's only using my CPU...which is SLOOOOOOW.  The problem 
               is that Ollama isn't launched in a straightforward way. The devs decided that it would be smart to construct the executable in such a way that I can't even open it with a text editor and look at the code. Can
               you say "CLOSED SOURCE"?  I can poke around in the other files, but really, I need to add extensions to the executable or figure out some other way to set the necessary variables to be compatible with Intel 
               GPUs. I'm blown away that there are packages out already that will handle this, but the Ollama devs just don't want to support Intel Arc...literally, in the init.py file you can see case statements for Nvidia 
               or AMD only...not even an else (*) case entry.  I'd add one for Intel if I knew the what and where for the other variables.  I may just mess around with it anyway.  If Ollama is installed directly to your PC, 
               it will work fine the way I had it before...but if you containerize it, there's issues.  Like I said, I do have it installed strictly in my environment now, but there's no actual GPU usage.  That's weird since 
               the ipex debugging info shows that my GPU is recognized, but the Ollama server always reverts back to using a default CPU runner...if only it was as easy as using ipexrun to start the ollama server....but no.
          I've been tooling around with several packages off and on bouncing between them....just chipping away at my list of packages I want to get working.  Fooocus is working gangbusters though...too bad the primary dev 
               decided to abandon it.  I'm looking to get another fork working...one that's being updated.
     *  1/5/25
          I performed a fresh install of AIInAAL last night and uncovered a couple of bugs.  I found a typo in the Fooocus installaion and have fixed that.
          So far, I've reinstalled both Fooocus and Forge and am using them without issue. I changed the default port for Forge so that it would be different from that of Fooocus to allow for bookmarking in your browswer.
          I got F5-TTS to install prior to my AIInAAL reinstall last night, but I'm still in the testing phase of that...seems that there was an issue regarding the tokenizer. Says it can't find it but spits out the correct address.
          I will likely remove DeFooocus and replace RoopUL with other packages. DeFooocus just adds a couple features (most of which I either don't use or have a standalone) and it just doesn't seem to be worth my time to keep 
               maintaining my version of it.  RoopUL is good...but I think there are some other packages that may do a better job at this point. We'll see after I do some testing.

