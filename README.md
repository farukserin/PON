# PON
Partition of Overlapped Nuclei

Matlab Code for "A novel overlapped nuclei splitting algorithm for histopathological images"

Abstract
Background and objective
Nuclei segmentation is a common process for quantitative analysis of histopathological images. However, this process generally results in overlapping of nuclei due to the nature of images, the sample preparation and staining, and image acquisition processes as well as insufficiency of 2D histopathological images to represent 3D characteristics of tissues. We present a novel algorithm to split overlapped nuclei.

Methods
The histopathological images are initially segmented by K-Means segmentation algorithm. Then, nuclei cluster are converted to binary image. The overlapping is detected by applying threshold area value to nuclei in the binary image. The splitting algorithm is applied to the overlapped nuclei. In first stage of splitting, circles are drawn on overlapped nuclei. The radius of the circles is calculated by using circle area formula, and each pixel's coordinates of overlapped nuclei are selected as center coordinates for each circle. The pixels in the circle that contains maximum number of intersected pixels in both the circle and the overlapped nuclei are removed from the overlapped nuclei, and the filled circle labeled as a nucleus.

Results
The algorithm has been tested on histopathological images of healthy and damaged kidney tissues and compared with the results provided by an expert and three related studies. The results demonstrated that the proposed splitting algorithm can segment the overlapping nuclei with accuracy of 84%.

Conclusions
The study presents a novel algorithm splitting the overlapped nuclei in histopathological images and provides more accurate cell counting in histopathological analysis. Furthermore, the proposed splitting algorithm has the potential to be used in different fields to split any overlapped circular patterns.
