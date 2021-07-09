# RLE_decompression
<h2>About RLE coding</h2>

In 80-90s, in the days which commodore64 and Atari 5200 were kings of the technology, the CompuServe, a major commercial online service provider in US, used RLE method to encode B&W images (notice that the word encode was used, not compress). The goal was to develop a system to transmit high resolution graphics images to different brands of computer. Different computer architectures have different way of displaying images. RLE was used to encode image binary codes, transmit it and then decode it on the receiver this way I can hand over my images without being concerned about what machine you're using. Some of the major application of RLE was to handle display of radar weather maps for National Weather Service (NWS), show pictures of missing persons and even FBI’s 10 most wanted list!!!!
<h2>TACO project</h2>
In this project we proposed a hardware implementation for RLE decompression unit. This acts as an accelerator beside main processor. It takes RLE-encoded binaies, and produce raw codes that can be used for data transfer between different architecture.
