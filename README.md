## cutndown

a script to crop a short span of a long youtube video

### Requirements

 * [youtube-dl](https://github.com/rg3/youtube-dl) for list-formats and print-json methods
 * [jq](https://stedolan.github.io/jq/) for parsing json
 * [ffmpeg](https://github.com/FFmpeg/FFmpeg) for cutting and downloading video from direct url

Be sure that these libraries are working before process.

### Todos
- [ ] Frame dropping problem

### Under the Hood

Step by step:

* userInput > Get video url
* youtube-dl > Lists the available formats
* userInput > Get preferred video format
* youtube-dl > save the json file to a file named json by using `--print-json`
* jq > Parse the json file. Get video's direct url. Type it on a file named called directUrl
* userInput > 'starts when', 'duration' and 'output filename'
* ffmpeg > Cuts video from direct url, saves it as 'filename_uncut.mp4'
* ffmpeg > Cuts video's first 3 seconds

The last step is required because of an unexpected result caused by ffmpeg (TODO).  The script uses the performant way of 'seek and save video'. Basically the command discards the seconds up until -ss parameter and saves the file the same duration as -t parameter, as a result some frames drop during this process. Therefore the last step is a temporary solution provided by myself and may be unable to work properly for every case.
