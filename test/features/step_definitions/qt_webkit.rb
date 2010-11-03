############################################################################
## 
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies). 
## All rights reserved. 
## Contact: Nokia Corporation (testabilitydriver@nokia.com) 
## 
## This file is part of TDriver. 
## 
## If you have questions regarding the use of this file, please contact 
## Nokia at testabilitydriver@nokia.com . 
## 
## This library is free software; you can redistribute it and/or 
## modify it under the terms of the GNU Lesser General Public 
## License version 2.1 as published by the Free Software Foundation 
## and appearing in the file LICENSE.LGPL included in the packaging 
## of this file. 
## 
############################################################################

# The testapp application example must be compiled and in PATH for these to work
# Author: Ville Kankainen
# Date: 27.10.2010
# Purpose: Testapp webkit helpers

require 'tdriver'

Then ("I should see \"$webelem\" having \"$attrib\" with value \"$value\"") do |webelem, attrib, value|
  elem = @app.send(webelem.to_sym, {attrib=>value})
  elem_l = elem.attribute("x").to_i 
  elem_r = elem_l + elem.attribute("width").to_i
  elem_u = elem.attribute("y").to_i 
  elem_d = elem_u + elem.attribute("height").to_i
  
  frame = @app.QWebFrame(:__index=>"2")
  frame_l = frame.attribute("x").to_i 
  frame_r = frame_l + frame.attribute("width").to_i
  frame_u = frame.attribute("y").to_i 
  frame_d = frame_u + frame.attribute("height").to_i


  verify_true(1) {(
                   (#fully inside
                    (elem_r <= frame_r) && 
                    (elem_l >= frame_l) &&
                    (elem_u >= frame_u) &&
                    (elem_d <= frame_d)
                   ) ||
                   (#partially inside
                    (
                     (elem_l >= frame_l && elem_l < frame_r) || 
                     (elem_r <= frame_r && elem_r > frame_l)
                    )&&
                    (
                     (elem_u >= frame_u && elem_u < frame_d) ||
                     (elem_d <= frame_d && elem_d > frame_u)
                    )
                   )
                  )
                  }
end

Then ("I should not see \"$webelem\" having \"$attrib\" with value \"$value\"") do |webelem, attrib, value|
  elem = @app.send(webelem.to_sym, {attrib=>value})
  
  elem_l = elem.attribute("x").to_i 
  elem_r = elem_l + elem.attribute("width").to_i
  elem_u = elem.attribute("y").to_i 
  elem_d = elem_u + elem.attribute("height").to_i
  
  frame = @app.QWebFrame(:__index=>"2")
  frame_l = frame.attribute("x").to_i 
  frame_r = frame_l + frame.attribute("width").to_i
  frame_u = frame.attribute("y").to_i 
  frame_d = frame_u + frame.attribute("height").to_i

  verify_true(1) { (elem_r < frame_l) ||
                   (elem_l > frame_r) ||
                   (elem_u > frame_d) ||
                   (elem_d < frame_u)}
end

Then ("I verify that \"$webelem\" is having \"$attrib\" with value \"$value\"") do |webelem, attrib, value|
  @app.send(webelem.to_sym, {attrib=>value}).name
end
