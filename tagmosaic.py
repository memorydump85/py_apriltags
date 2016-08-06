from __future__ import division


#--------------------------------------
class Tag36h11Mosaic(object):
#--------------------------------------
    """
    The tag mosaic for the 36h11 family consists of 587 tags
    laid out in 25 rows and 24 columns.

    Without loss of generality, we assume that the center of
    tag 0 lies at (0, 0).
    """
    def __init__(self, tag_spacing_meters):
        self.scale = tag_spacing_meters

    def get_position_meters(self, id_):
        row, col = id_ % 24, -(id_ // 24)
        return row*self.scale, col*self.scale

    def get_row(self, id_):
        return id_ // 24

    def get_col(self, id_):
        return id_ % 24
