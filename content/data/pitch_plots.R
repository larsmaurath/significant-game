library("ggplot2")

create_StatsBomb_GoalMap <- function(grass_colour, line_colour, background_colour, goal_colour){
  
  theme_blankPitch = function(size=12) { 
    theme(
      #axis.line=element_blank(), 
      axis.text.x=element_blank(), 
      axis.text.y=element_blank(), 
      #axis.ticks.y=element_text(size=size),
      #   axis.ticks=element_blank(),
      axis.ticks.length=unit(0, "lines"), 
      #axis.ticks.margin=unit(0, "lines"), 
      axis.title.x=element_blank(), 
      axis.title.y=element_blank(), 
      legend.background=element_rect(fill=background_colour, colour=NA), 
      legend.key=element_rect(colour=background_colour,fill=background_colour), 
      legend.key.size=unit(1.2, "lines"), 
      legend.text=element_text(size=size), 
      legend.title=element_text(size=size, face="bold",hjust=0),
      strip.background = element_rect(colour = background_colour, fill = background_colour, size = .5),
      panel.background=element_rect(fill=background_colour,colour=background_colour), 
      #       panel.border=element_blank(), 
      panel.grid.major=element_blank(), 
      panel.grid.minor=element_blank(), 
      panel.spacing=element_blank(), 
      plot.background=element_blank(), 
      plot.margin=unit(c(0, 0, 0, 0), "lines"), 
      plot.title=element_text(size=size*1.2), 
      strip.text.y=element_text(colour=background_colour,size=size,angle=270),
      strip.text.x=element_text(size=size*1))}
  
  zmin <- 0 # minimum width
  zmax <- 10 # maximum width
  ymin <- 25 # minimum length
  ymax <- 55 # maximum length
  
  # Defining features along the length
  goalCrossbar <- 2.67
  goalMin <- 0.0
  
  # Defining features along the width
  goalPostLeft <- 36
  goalPostRight <- 44
  
  ## initiate the plot, set some boundries to the plot
  p <- ggplot() + xlim(c(ymin,ymax)) + ylim(c(zmin,zmax)) +
    # add the theme 
    theme_blankPitch() +
    geom_rect(aes(xmin = ymin, xmax = ymax, ymin = zmin, ymax = zmin), fill = grass_colour, colour = line_colour) +
    geom_rect(aes(xmin = goalPostLeft, xmax = goalPostRight, ymin = goalMin, ymax = goalCrossbar), fill = grass_colour, colour = line_colour) + 
    coord_fixed(ratio = 1)
  
  return(p)
  
}

create_StatsBomb_ShotMap <- function(grass_colour, line_colour, background_colour, goal_colour){
  
  theme_blankPitch = function(size=12) { 
    theme(
      #axis.line=element_blank(), 
      axis.text.x=element_blank(), 
      axis.text.y=element_blank(), 
      #axis.ticks.y=element_text(size=size),
      #   axis.ticks=element_blank(),
      axis.ticks.length=unit(0, "lines"), 
      #axis.ticks.margin=unit(0, "lines"), 
      axis.title.x=element_blank(), 
      axis.title.y=element_blank(), 
      legend.background=element_rect(fill=background_colour, colour=NA), 
      legend.key=element_rect(colour=background_colour,fill=background_colour), 
      legend.key.size=unit(1.2, "lines"), 
      legend.text=element_text(size=size), 
      legend.title=element_text(size=size, face="bold",hjust=0),
      strip.background = element_rect(colour = background_colour, fill = background_colour, size = .5),
      panel.background=element_rect(fill=background_colour,colour=background_colour), 
      #       panel.border=element_blank(), 
      panel.grid.major=element_blank(), 
      panel.grid.minor=element_blank(), 
      panel.spacing=element_blank(), 
      plot.background=element_blank(), 
      plot.margin=unit(c(0, 0, 0, 0), "lines"), 
      plot.title=element_text(size=size*1.2), 
      strip.text.y=element_text(colour=background_colour,size=size,angle=270),
      strip.text.x=element_text(size=size*1))}
  
  ymin <- 0 # minimum width
  ymax <- 80 # maximum width
  xmin <- 60 # minimum length
  xmax <- 120 # maximum length
  
  # Defining features along the length
  boxEdgeOff <- 102
  sixYardOff <- 114
  penSpotOff <- 108
  halfwayline <- 60
  
  # Defining features along the width
  boxEdgeLeft <- 18
  boxEdgeRight <- 62
  sixYardLeft <- 30 
  sixYardRight <- 50
  goalPostLeft <- 36
  goalPostRight <- 44
  CentreSpot <- 40   
  
  # other dimensions
  centreCirle_d <- 20   
  
  ## define the circle function
  circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
    r = diameter / 2
    tt <- seq(0,2*pi,length.out = npoints)
    xx <- center[1] + r * cos(tt)
    yy <- center[2] + r * sin(tt)
    return(data.frame(x = xx, y = yy))
  }
  
  #### create leftD arc ####
  dArc <- circleFun(c((40),(penSpotOff)),centreCirle_d,npoints = 1000)
  ## remove part that is in the box
  dArc <- dArc[which(dArc$y <= (boxEdgeOff)),]
  
  ## initiate the plot, set some boundries to the plot
  p <- ggplot() + xlim(c(ymin,ymax)) + ylim(c(xmin,xmax)) +
    # add the theme 
    theme_blankPitch() +
    # add the base rectangle of the pitch 
    geom_rect(aes(xmin=ymin, xmax=ymax, ymin=xmin, ymax=xmax), fill = grass_colour, colour = line_colour) +
    # add the 18 yard box offensive
    geom_rect(aes(xmin=boxEdgeLeft, xmax=boxEdgeRight, ymin=boxEdgeOff, ymax=xmax), fill = grass_colour, colour = line_colour) +
    # add the six yard box offensive
    geom_rect(aes(xmin=sixYardLeft, xmax=sixYardRight, ymin=sixYardOff, ymax=xmax), fill = grass_colour, colour = line_colour) +
    # add the arc circle 
    geom_path(data=dArc, aes(x=x,y=y), colour = line_colour) +
    # add the goal offensive
    geom_segment(aes(x = goalPostLeft, y = xmax, xend = goalPostRight, yend = xmax),colour = goal_colour, size = 1)
  
  return(p)
  
}

create_opta_ShotMap <- function(grass_colour, line_colour, background_colour, goal_colour){
  
  theme_blankPitch = function(size=12) { 
    theme(
      #axis.line=element_blank(), 
      axis.text.x=element_blank(), 
      axis.text.y=element_blank(), 
      #axis.ticks.y=element_text(size=size),
      #   axis.ticks=element_blank(),
      axis.ticks.length=unit(0, "lines"), 
      #axis.ticks.margin=unit(0, "lines"), 
      axis.title.x=element_blank(), 
      axis.title.y=element_blank(), 
      legend.background=element_rect(fill=background_colour, colour=NA), 
      legend.key=element_rect(colour=background_colour,fill=background_colour), 
      legend.key.size=unit(1.2, "lines"), 
      legend.text=element_text(size=size), 
      legend.title=element_text(size=size, face="bold",hjust=0),
      strip.background = element_rect(colour = background_colour, fill = background_colour, size = .5),
      panel.background=element_rect(fill=background_colour,colour=background_colour), 
      #       panel.border=element_blank(), 
      panel.grid.major=element_blank(), 
      panel.grid.minor=element_blank(), 
      panel.spacing=element_blank(), 
      plot.background=element_blank(), 
      plot.margin=unit(c(0, 0, 0, 0), "lines"), 
      plot.title=element_text(size=size*1.2), 
      strip.text.y=element_text(colour=background_colour,size=size,angle=270),
      strip.text.x=element_text(size=size*1))}
  
  ymin <- 0 # minimum width
  ymax <- 100 # maximum width
  xmin <- 50 # minimum length
  xmax <- 100 # maximum length
  
  # Defining features along the length
  boxEdgeOff <- 83
  sixYardOff <- 94.2
  penSpotOff <- 88.5
  halfwayline <- 50
  
  # Defining features along the width
  boxEdgeLeft <- 21.1
  boxEdgeRight <- 78.9
  sixYardLeft <- 36.8 
  sixYardRight <- 63.2
  goalPostLeft <- 45.2
  goalPostRight <- 54.8
  CentreSpot <- 50   
  
  # other dimensions
  centreCirle_d <- 15   
  
  ## define the circle function
  circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
    r = diameter / 2
    tt <- seq(0,2*pi,length.out = npoints)
    xx <- center[1] + r * cos(tt)
    yy <- center[2] + r * sin(tt)
    return(data.frame(x = xx, y = yy))
  }
  
  #### create leftD arc ####
  dArc <- circleFun(c((50),(penSpotOff)),centreCirle_d,npoints = 1000)
  ## remove part that is in the box
  dArc <- dArc[which(dArc$y <= (boxEdgeOff)),]
  
  ## initiate the plot, set some boundries to the plot
  p <- ggplot() + xlim(c(ymin,ymax)) + ylim(c(xmin,xmax)) +
    # add the theme 
    theme_blankPitch() +
    # add the base rectangle of the pitch 
    geom_rect(aes(xmin=ymin, xmax=ymax, ymin=xmin, ymax=xmax), fill = grass_colour, colour = line_colour) +
    # add the 18 yard box offensive
    geom_rect(aes(xmin=boxEdgeLeft, xmax=boxEdgeRight, ymin=boxEdgeOff, ymax=xmax), fill = grass_colour, colour = line_colour) +
    # add the six yard box offensive
    geom_rect(aes(xmin=sixYardLeft, xmax=sixYardRight, ymin=sixYardOff, ymax=xmax), fill = grass_colour, colour = line_colour) +
    # add the arc circle 
    geom_path(data=dArc, aes(x=x,y=y), colour = line_colour) +
    # add the goal offensive
    geom_segment(aes(x = goalPostLeft, y = xmax, xend = goalPostRight, yend = xmax),colour = goal_colour, size = 1)
  
  return(p)
  
}

create_opta_Pitch <- function(grass_colour, line_colour, background_colour, goal_colour, goaltype = "line", middlethird = FALSE, BasicFeatures = FALSE, JdeP = FALSE, arcs = TRUE, direction = TRUE, padding = 3){

  ## set theme for blank pitch
  theme_blankPitch = function(size=12) {
    theme(
      #axis.line=element_blank(),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      #axis.ticks.y=element_text(size=size),
      #   axis.ticks=element_blank(),
      axis.ticks.length=unit(0, "lines"),
      #axis.ticks.margin=unit(0, "lines"),
      axis.title.x=element_blank(),
      axis.title.y=element_blank(),
      legend.background=element_rect(fill=background_colour, colour=NA),
      legend.key=element_rect(colour=background_colour,fill=background_colour),
      legend.key.size=unit(1.2, "lines"),
      legend.text=element_text(size=size),
      legend.title=element_text(size=size, face="bold",hjust=0),
      strip.background = element_rect(colour = background_colour, fill = background_colour, size = .5),
      panel.background=element_rect(fill=background_colour,colour=background_colour),
      #       panel.border=element_blank(),
      panel.grid.major=element_blank(),
      panel.grid.minor=element_blank(),
      panel.spacing=element_blank(),
      plot.background=element_blank(),
      plot.margin=unit(c(0, 0, 0, 0), "lines"),
      plot.title=element_text(size=size*1.2),
      strip.text.y=element_text(colour=background_colour,size=size,angle=270),
      strip.text.x=element_text(size=size*1))}
  
  padding_x <- padding
  padding_y <- padding_x * 105 / 68
  
  ymin <- 0 # minimum width
  ymax <- 100 # maximum width
  xmin <- 0 # minimum length
  xmax <- 100 # maximum length
  
  # Defining features along the length
  
  boxEdgeOff <- 83
  boxEdgeDef <- 100 - boxEdgeOff
  halfwayline <- 50
  sixYardOff <- 94.2
  sixYardDef <- 100 - sixYardOff
  penSpotOff <- 88.5
  penSpotDef <- 100 - penSpotOff

  # Defining features along the width
  boxEdgeLeft <- 21.1
  boxEdgeRight <- 78.9
  sixYardLeft <- 36.8 
  sixYardRight <- 63.2
  goalPostLeft <- 45.2
  goalPostRight <- 54.8
  CentreSpot <- 50  
  
  # other dimensions
  centreCirle_d <- 20
  
  ## define the circle function
  circleFun <- function(center = c(50,50), diameter = 10, npoints = 50){
    r_x = diameter / 2
    r_y = r_x * 105 / 68
    tt <- seq(0, 2*pi, length.out = npoints)
    xx <- center[1] + r_x * cos(tt)
    yy <- center[2] + r_y * sin(tt)
    return(data.frame(x = xx, y = yy))
  }
  
  #### create center circle ####
  center_circle <- circleFun(c(halfwayline, CentreSpot), centreCirle_d, npoints = 100)
  
  ### FIRST STAGE
  ## initiate the plot, set some boundries to the plot
  p <- ggplot() + xlim(c(xmin - padding_x, xmax + padding_x)) + ylim(c( ymin - padding_y, ymax + padding_y)) +
    theme_blankPitch()
  
  ### ADD MIDDLE THIRD SHADING
  if(middlethird == TRUE){
    p <- p + geom_rect(aes(xmin = (xmax / 3 * 1), xmax = ( xmax / 3 * 2), ymin = ymin, ymax = ymax), colour = NA, fill = "black", alpha = 0.10)
  }
  
  if(BasicFeatures == TRUE){
    p <- p +
      # add the base rectangle of the pitch
      geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = NA, colour = line_colour) +
      # add the 18 yard box defensive
      geom_rect(aes(xmin = xmin, xmax = boxEdgeDef, ymin = boxEdgeLeft, ymax = boxEdgeRight), fill = grass_colour, colour = line_colour) +
      # add the 18 yard box offensive
      geom_rect(aes(xmin = boxEdgeOff, xmax = xmax, ymin = boxEdgeLeft, ymax = boxEdgeRight), fill = grass_colour, colour = line_colour) +
      # add halway line
      geom_segment(aes(x = halfwayline, y = ymin, xend = halfwayline, yend = ymax),colour = line_colour)
    arcs = FALSE
  }else{
    ## initiate the plot, set some boundries to the plot
    p <- p +
      # add the base rectangle of the pitch
      geom_rect(aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), fill = NA, colour = line_colour) +
      # add the 18 yard box defensive
      geom_rect(aes(xmin=xmin, xmax=boxEdgeDef, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = grass_colour, colour = line_colour) +
      # add the 18 yard box offensive
      geom_rect(aes(xmin=boxEdgeOff, xmax=xmax, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = grass_colour, colour = line_colour) +
      # add halway line
      geom_segment(aes(x = halfwayline, y = ymin, xend = halfwayline, yend = ymax),colour = line_colour) +
      # add the six yard box Defensive
      geom_rect(aes(xmin=xmin, xmax=sixYardDef, ymin=sixYardLeft, ymax=sixYardRight), fill = grass_colour, colour = line_colour)  +
      # add the six yard box offensive
      geom_rect(aes(xmin=sixYardOff, xmax=xmax, ymin=sixYardLeft, ymax=sixYardRight), fill = grass_colour, colour = line_colour) +
      # add centre circle
      geom_path(data = center_circle, aes(x = x, y = y), colour = line_colour) +
      # add penalty spot left
      geom_point(aes(x = penSpotDef , y = CentreSpot), colour = line_colour, size = 0.75) +
      # add penalty spot right
      geom_point(aes(x = penSpotOff , y = CentreSpot), colour = line_colour, size = 0.75) +
      # add centre spot
      geom_point(aes(x = halfwayline , y = CentreSpot), colour = line_colour, size = 0.75) }
  
  #### add goals depending on type
  
  ## LINE TYPE
  if(goaltype == "line"){
    p <- p +
      # add the goal Defensive
      geom_segment(aes(x = xmin, y = goalPostLeft, xend = xmin, yend = goalPostRight),colour = goal_colour, size = 1) +
      # add the goal offensive
      geom_segment(aes(x = xmax, y = goalPostLeft, xend = xmax, yend = goalPostRight),colour = goal_colour, size = 1)
    
  }else{}
  
  ## Barca Numbers TYPE
  if(goaltype == "barcanumbers"){
    p <- p +
      # add the goal Defensive
      geom_segment(aes(x = xmin - 0.75, y = goalPostLeft, xend = xmin - 0.75, yend = goalPostRight),colour = line_colour, size = 0.75) +
      # add the goal offensive
      geom_segment(aes(x = xmax + 0.75, y = goalPostLeft, xend = xmax + 0.75, yend = goalPostRight),colour = line_colour, size = 0.75)
    
  }else{}
  
  ## BOX TYPE
  if(goaltype == "box"){
    p <- p +
      # add the goal Defensive
      geom_rect(aes(xmin = xmin - 2 , ymin = goalPostLeft, xmax = xmin, ymax = goalPostRight), fill = grass_colour, colour = line_colour) +
      # add the goal offensive
      geom_rect(aes(xmin = xmax, ymin = goalPostLeft, xmax = xmax + 2, ymax = goalPostRight), fill = grass_colour, colour = line_colour)
  }else{}
  
  
  ## add J de P
  if(JdeP == TRUE){
    p <- p +
      # vertical tram lines
      geom_segment(aes(x = boxEdgeDef, y = boxEdgeLeft, xend = boxEdgeOff, yend = boxEdgeLeft), colour = "#941C07", alpha = 0.3) +
      geom_segment(aes(x = boxEdgeDef, y = boxEdgeRight, xend = boxEdgeOff, yend = boxEdgeRight), colour = "#941C07", alpha = 0.3) +
      geom_segment(aes(x = boxEdgeDef, y = CentreSpot - 10, xend = boxEdgeOff, yend = CentreSpot - 10), colour = "#941C07", alpha = 0.3) +
      geom_segment(aes(x = boxEdgeDef, y = CentreSpot + 10, xend = boxEdgeOff, yend = CentreSpot + 10), colour = "#941C07", alpha = 0.3) +
      # horizontal tram lines
      geom_segment(aes(x = boxEdgeDef, y = ymin, xend = boxEdgeDef, yend = ymax), colour = "#941C07", alpha = 0.3) +
      geom_segment(aes(x = boxEdgeOff, y = ymin, xend = boxEdgeOff, yend = ymax), colour = "#941C07", alpha = 0.3) +
      geom_segment(aes(x = (xmax/3*1), y = boxEdgeRight, xend = (xmax/3*1), yend = ymax), colour = "#941C07", alpha = 0.3) +
      geom_segment(aes(x = (xmax/3*1), y = boxEdgeLeft, xend = (xmax/3*1), yend = ymin), colour = "#941C07", alpha = 0.3) +
      geom_segment(aes(x = (xmax/3*2), y = boxEdgeRight, xend = (xmax/3*2), yend = ymax), colour = "#941C07", alpha = 0.3) +
      geom_segment(aes(x = (xmax/3*2), y = boxEdgeLeft, xend = (xmax/3*2), yend = ymin), colour = "#941C07", alpha = 0.3)
    # add the 18 yard box defensive
    #geom_rect(aes(xmin=xmin, xmax=boxEdgeDef, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = NA, colour = line_colour) +
    # add the 18 yard box offensive
    #geom_rect(aes(xmin=boxEdgeOff, xmax=xmax, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = NA, colour = line_colour)
  }else{}
  
  ## Add arcs
  if(arcs == TRUE){
    p <- p +
      # vertical tram lines
      annotate("path",
               x = (xmax-penSpotOff) + 10 * cos(seq(-0.3*pi, 0.3*pi, length.out = 30)),
               y = CentreSpot + 10 * sin(seq(-0.3*pi, 0.3*pi, length.out = 30)),
               col = line_colour) +
      annotate("path",
               x = penSpotOff - 10 * cos(seq(-0.3*pi, 0.3*pi, length.out = 30)),
               y = CentreSpot + 10 * sin(seq(-0.3*pi, 0.3*pi, length.out = 30)),
               col = line_colour)
  }

  ## Add direction of play
  if(direction){
    p <- p +
      geom_segment(data = data.frame(x = xmax / 3, xend = xmax * 2 / 3, y = ymin - padding_y, yend = ymin - padding_y), 
                   aes(x = x, y = y, xend = xend, yend = yend), color = "grey", arrow = arrow(length = unit(0.02, "npc")))
  }
    
  return(p)
  
}

create_opta_Pitch_basic <- function(grass_colour, line_colour, background_colour, goal_colour, padding = 3){
  
  ## set theme for blank pitch
  theme_blankPitch = function(size=12) {
    theme(
      #axis.line=element_blank(),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      #axis.ticks.y=element_text(size=size),
      #   axis.ticks=element_blank(),
      axis.ticks.length=unit(0, "lines"),
      #axis.ticks.margin=unit(0, "lines"),
      axis.title.x=element_blank(),
      axis.title.y=element_blank(),
      legend.background=element_rect(fill=background_colour, colour=NA),
      legend.key=element_rect(colour=background_colour,fill=background_colour),
      legend.key.size=unit(1.2, "lines"),
      legend.text=element_text(size=size),
      legend.title=element_text(size=size, face="bold",hjust=0),
      strip.background = element_rect(colour = background_colour, fill = background_colour, size = .5),
      panel.background=element_rect(fill=background_colour,colour=background_colour),
      #       panel.border=element_blank(),
      panel.grid.major=element_blank(),
      panel.grid.minor=element_blank(),
      panel.spacing=element_blank(),
      plot.background=element_blank(),
      plot.margin=unit(c(0, 0, 0, 0), "lines"),
      plot.title=element_text(size=size*1.2),
      strip.text.y=element_text(colour=background_colour,size=size,angle=270),
      strip.text.x=element_text(size=size*1))}
  
  padding_x <- padding
  padding_y <- padding_x * 105 / 68
  
  ymin <- 0 # minimum width
  ymax <- 100 # maximum width
  xmin <- 0 # minimum length
  xmax <- 100 # maximum length
  
  # Defining features along the length
  
  boxEdgeOff <- 83
  boxEdgeDef <- 100 - boxEdgeOff
  halfwayline <- 50
  sixYardOff <- 94.2
  sixYardDef <- 100 - sixYardOff
  penSpotOff <- 88.5
  penSpotDef <- 100 - penSpotOff
  
  # Defining features along the width
  boxEdgeLeft <- 21.1
  boxEdgeRight <- 78.9
  sixYardLeft <- 36.8 
  sixYardRight <- 63.2
  goalPostLeft <- 45.2
  goalPostRight <- 54.8
  CentreSpot <- 50  
  
  # other dimensions
  centreCirle_d <- 20
  
  ## define the circle function
  circleFun <- function(center = c(50,50), diameter = 10, npoints = 50){
    r_x = diameter / 2
    r_y = r_x * 105 / 68
    tt <- seq(0, 2*pi, length.out = npoints)
    xx <- center[1] + r_x * cos(tt)
    yy <- center[2] + r_y * sin(tt)
    return(data.frame(x = xx, y = yy))
  }
  
  #### create center circle ####
  center_circle <- circleFun(c(halfwayline, CentreSpot), centreCirle_d, npoints = 100)
  
  ### FIRST STAGE
  ## initiate the plot, set some boundries to the plot
  p <- ggplot() + xlim(c(xmin - padding_x, xmax + padding_x)) + ylim(c( ymin - padding_y, ymax + padding_y))
  
  return(p)
  
}