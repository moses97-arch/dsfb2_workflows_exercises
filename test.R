library(tidyverse)
library(nlme)

set.seed(123)

ergoStool %>% as_tibble()

plot_ergo <- ergoStool %>%
  ggplot(aes(x = reorder(Type, effort), y = effort)) +
  geom_boxplot(colour = "darkgreen", outlier.shape = NA) +
  geom_jitter(aes(colour = reorder(Subject, -effort)), 
              width = 0.2, size = 3) +
  scale_color_manual(
    values = c(
      "red","blue", 
      "green", "darkblue", 
      "darkgreen", "purple", 
      "grey", "black", "darkgrey"),
  ) +
  ylab("Effort (Borg scale score)") +
  xlab("Chair type") +
  guides(colour=guide_legend(title = "Subject ID")) +
  theme_bw()

plot_ergo

ergo_model <- lme(
  data = ergoStool,
  fixed = effort ~ Type,
  random = ~1 | Subject
)

plot_ergo_slopes <- ergoStool %>%
  ggplot(aes(x = reorder(Type, effort), y = effort)) + 
  geom_jitter(aes(colour = reorder(Subject, -effort)), 
              width = 0.2, size = 3) +
  geom_smooth(aes(group = Subject, colour = Subject), method = lm, se = FALSE) +
  scale_colour_manual(
    values = c(
      "red","blue", 
      "green", "darkblue", 
      "darkgreen", "purple", 
      "grey", "black", "darkgrey")
  ) + 
  ylab("Effort (Borg scale score)") +
  xlab("Chair type") + 
  guides(colour=guide_legend(title="Subject id")) +
  theme_bw()

plot_ergo_slopes

result <- ergo_model %>% summary()
result$tTable %>% as.data.frame() %>% knitr::kable()
plot(ergo_model)

library(ggsignif)

p_values <- result$tTable %>% as.data.frame()
annotation_df <- data.frame(Type=c("T1", "T2"), 
                            start=c("T1", "T1"), 
                            end=c("T2", "T3"),
                            y=c(16, 14),
                            label=
                              paste("p-value:",
                                    c(
                                      formatC(
                                        p_values$`p-value`[2], digits = 3),
                                      formatC(
                                        p_values$`p-value`[3], digits = 3)
                                    )
                              )
)
str(annotation_df)

set.seed(123)
ergoStool %>%
  ggplot(aes(x = reorder(Type, effort), 
             y = effort)) + 
  geom_boxplot(colour = "darkgreen", 
               outlier.shape = NA) + 
  geom_jitter(aes(
    colour = reorder(Subject, -effort)), 
    width = 0.2, 
    size = 3) +
  scale_colour_manual(
    values = c(
      "red", "blue","green", 
      "darkblue", "darkgreen", 
      "purple", "grey", "black", 
      "darkgrey")) +
  ylab("Effort (Borg scale score)") +
  xlab("Chair type") + 
  guides(colour=guide_legend(title="Subject id")) +
  ylim(c(6,20)) +
  geom_signif(
    data =annotation_df,
    aes(xmin=start,
        xmax=end,
        annotations=label,
        y_position=y),
    textsize = 5, vjust = -0.2, manual = TRUE) +
  theme_bw() -> plot_ergo
  