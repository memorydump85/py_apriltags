import sys
import numpy as np
from skimage.io import imread
from skimage.color import rgb2gray
from skimage.util import img_as_ubyte
from apriltag_wrap import AprilTagDetector


def main():
    if len(sys.argv) != 2:
        print >>sys.stderr, "  USAGE: %s <image_file>" % sys.argv[0]
        sys.exit(-1)

    im = imread(sys.argv[1])
    im = img_as_ubyte(rgb2gray(im))

    tagdetector = AprilTagDetector()
    detections = tagdetector.detect(im)
    print "\n".join([ str((d.id, d.c)) for d in detections ])
    print "%d tags found" % len(detections)

if __name__ == '__main__':
    main()