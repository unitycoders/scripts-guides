#!/usr/bin/env python3

import cv2
from matplotlib import pyplot as plt

img = cv2.imread("<image_name>")
orb = cv2.ORB_create()
kps = orb.detect(img)

kpimg = cv2.drawKeypoints(img, kps, None, None, cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)
plt.imshow(kpimg)
plt.show()
