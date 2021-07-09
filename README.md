# RLE_decompression
<h2>TACO project</h2>
TACO pursues the idea of a configurable compression/decompression hardware architecture, to be used as an accelerator.

<h2>About RLE coding</h2>
In 80-90s, in the days which commodore64 and Atari 5200 were kings of technology, CompuServe, a major commercial online service provider in the US, used the RLE method to encode B&W images (notice that the word encode was used, not compress). The goal was to develop a system to transmit high-resolution graphics images to different brands of computers. Different computer architectures have different ways of displaying images. RLE was used to encode image binary codes, transmit them and then decode them on the receiver this way I can hand over my images without being concerned about what machine you're using. Some of the major application of RLE was to handle display of radar weather maps for National Weather Service (NWS), show pictures of missing persons and even FBI’s 10 most wanted list!!!!

<h2>Our Project</h2>
In this project we proposed a hardware implementation for RLE decompression unit. This acts as an accelerator beside main processor. It takes RLE-encoded binaies, and produce raw codes that can be used for data transfer between different architecture.
