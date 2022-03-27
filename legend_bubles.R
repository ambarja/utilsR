gg_circle <- function(r, xc, yc, color="black", fill=NA, ...) {
  x <- xc + r*cos(seq(0, pi, length.out=100))
  ymax <- yc + r*sin(seq(0, pi, length.out=100))
  ymin <- yc + r*sin(seq(0, -pi, length.out=100))
  annotate("ribbon", x=x, ymin=ymin, ymax=ymax, color=color, fill=fill, ...)
}
square <- ggplot(data.frame(x=0:1, y=0:1), aes(x=x, y=y))


square + 
  gg_circle(r=0.25, xc=0, yc=-0.25) + 
  gg_circle(r=0.5, xc=-0, yc=0) + 
  gg_circle(r=0.75, xc=0, yc=0.25) + 
  gg_circle(r=1.0, xc=0, yc=0.50) + 
  theme(panel.grid = element_blank(),
        panel.border = element_blank(),
        plot.title = element_markdown(size = 14,face = "bold"),
        axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.y = element_blank(),
        panel.background = element_blank(),
        axis.text.x = element_blank(),
        legend.position = "none") + 
  labs(x = "", y = "") + 
  geom_segment(aes(x = 0, y = 0.00, xend = 1.5, yend = 0.0),size=1) + 
  geom_segment(aes(x = 0, y = 0.50, xend = 1.5, yend = 0.5),size=1) +
  geom_segment(aes(x = 0, y = 1.00, xend = 1.5, yend = 1.0),size=1) + 
  geom_segment(aes(x = 0, y = 1.50, xend = 1.5, yend = 1.5),size=1) 
