# AIInAAL
AIInAAL - pronounced (ān-ᵊl) or 'anal' in English...fun acronym for AI-IntelArc-ArchLinux. It is a framework for installing and running popular AI software on Arch Linux using Intel Arc GPUs.

# How You Can Support Development  

[<img align="left" width="20%" src="https://media.giphy.com/media/hXMGQqJFlIQMOjpsKC/giphy.gif">](https://bmc.link/OCD_Insomniac)  

*    Please consider supporting me with [Buy Me A Coffee](https://bmc.link/OCD_Insomniac)!
*    Get the buzz out by reviewing and sharing on social networks like Facebook, Twitter (formerly), BlueSky etc...
*    Consider purchasing something from the [Amazon wishlist](https://www.amazon.com/hz/wishlist/ls/25OBUY6VTN1C8?ref_=wl_share)...items I always need more of. (Mouses, Keyboards, Storage, etc...)
*    [<img align="left" width="10%" src="https://m.media-amazon.com/images/I/41CMZ4XoAJL._SS135_.jpg">](https://www.amazon.com/hz/wishlist/ls/25OBUY6VTN1C8?ref_=wl_share)
<br clear="left"/>

# What's Currently Working (4/1/2025)
*   ComfyUI
     - Installs and works as it should. Tied to the shared folder like all other packages working in AIInAAL, so make sure you have one.
     - The shared1 folder is provided as a structure template, so if you don't have a "shared" folder, just rename it by removing the 1 at the end.
     - I have noticed that some node packages require tensorflow or onnxruntime. Be cautious what you install. Look at the package requirements.txt file.
          Some custom nodes packages can break your install since they will try to install packages through pip.
          
*   Ollama (via Terminal)
     - I've implemented the portable version of ollama created by the IPEX team. It is created as a standalone, but I'm made some modifications so it works
          with the AIInAAL framework.
     - IMPORTANT: Make sure that ReBAR is enabled properly in your BIOS and is fully functional. I found a setting I needed to set that was causing Ollama
          to load the LLM properly into VRAM, but would only run inference through the CPU. Getting ReBAR set properly makes the LLM responses FLY on my
          A770. The ReBAR functionality is absolutely worth the time to check and re-check.

*   F5-TTS (Need to test...again)
     - Installs and runs. I have been able to generate a reference voice file and then create speech in the cloned voice.
     - The initial tests prove...well, less than I had hoped for. The end result seems choppy...speed is too fast. Can't say certain
       words...etc. Perhaps it's my reference. I dunno... It installs and works so give it a whirl if you like, but I'd keep expectations low-ish.

# Recently jacked up...(4/1/2025)

     Farily recent update to Intel extensions for pytorch has created a problem with GLIBC 2.41...apparently. SEE: https://github.com/intel/intel-extension-for-pytorch/issues/794 . I would say this is Arch specific, but it seems to be affecting any distro dependent on GLIBC 2.41
          For now, we'll need to wait for a fix. It seems that several packages have been effected. Evident if you see this error: "ImportError: libintel-ext-pt-cpu.so: cannot enable executable stack as shared object requires: Invalid argument"
*    Open WebUI (Ollama Frontend) - Also jacked up with the GLIBC update...pretty much anything relying on ChromaDB seems to be jacked up now.
          Looking for a suitable ollama frontend as a replacement now.
*    CrewAI falls into the "Jacked up due to ChromaDB/GLIBC" category as well.
*    OmniGen (WIP but generating images) - BROKEN
          -TODO:  Shared folder links
               Initial model download is 15GB+ - Test smaller models             
*    Fooocus
*    DeFooocus
*    Forge

Remember that there are limitations beyond my control...like memory management, for example. AIInAAL is a framework for these packages to be installed, but ultimately, these versions, while more versitile and convenient, are the original programs at their core. I've done my best to get them to work with Intel Arc dGPUs on Arch, but this entire project is always a WIP. Keep that in mind before you try to flame me if using something you got for free misbehaves...

# Recent Notes from JT/OCD
     *  4/1/2025
          I've been screwing around with trying to rectify this GLIBC issue. It seems that the GLIBC issue directly affects ChromaDB...which many packages
               use to load onnxruntime. You see it plain as day when you try to run Open WebUI or CrewAI and probably several other apps. As long as ChromaDB's
               code uses importlib (GLIBC instruction, I think) to try to load onnxruntime for thieir Onnx_Mini package, it will fail...something's changed and it doesn't see the library.
               It's clearly installed..as onnxruntime or, more likely, onnxruntime-openvino...but ChromaDB just doesn't see it...period.  I could be wrong, but these are my observations.  If apps have a check in place that relies on ChromaDB or importlib, most likely it'll be jacked up.  That's why ComfyUI works properly, I think...it doesn't seem to do these checks the same way. I dunno...still looking into it and not 100% certain.
          So..to sum up the "State of AIInALL" : We have IPEX version issues and GLIBC/ChromaDB issues...would be so much easier if we could just use a VULKAN
               backend for most (if not all) of these AI programs. Working on that too...but none is even close to deployment for AIInAAL.
	*  3/27/2025
		Alright...OmniGen has been affected by the IPEX version issues as well..so it's int the "Recently jacked up..." section now..which sux. I am glad
			to say that I've gotten Ollama flying along and working gangbusters. I implemented the portable version the IPEX team created and after finding
			an extra setting on my mobo's BIOS that actually fully enables ReBAR, my A770 is rocking a 21b model without issue. Open WebUI is also now working
			as it should when using Firefox.  Sidenote: I have sucessfully ran a Deepseek model on it.
		I have also been doing some work on an AIInAAL Browser located in the Scripts directory. It loads and runs most websites, but it's a barebones browser
			and still lacks a bunch of functionality.  The idea is to have a builtin browser that can open all of these UIs in a uniform manor in order to
			eliminate some issues when using different browsers. For example, I noticed that Open WebUI (Ollama frontend) opens fine in Firefox, but not in
			Eollie (Gnome browser).  It was working before, but (I think) the GLIBC update broke some functionality...not sure.  I figured that if I can build
			my own browser and be able to control (to a degree) updates, that might make AIInAAL more stable.  The AB is a WIP and will not open ComfyUI due to
			a lack of support for certain element calls. I'm working on it, but this is more of a side feature I'm working on. AB will open most websites..even
			let you watch YouTube in fullscreen (I just fixed that). I'll need to create a proper installer/launcher for it...but as it sits now, it can be run
			by launching the temporary launcher file in a terminal like so: <address to AIInAAL/Scripts/AIInAAL_Browser>/AIInAAL-Browser-Start.sh
			You can also pass a URL if you want AB to go diretctly there by adding the FULL URL (needs the http://...) afterward. 
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
