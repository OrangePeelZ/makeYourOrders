# makeYourOrders

This project aims at creating a R framework for the online order system hosted on shiny server. R shiny enable lots of flexibility in post-order analysis, like collecting monthly/yearly statistics, which is helpful for business to make decisions.

This system enables interaction between customers, sales and backend services (e.g. the cook in the restaurant) by gathering commands from all the sides, exchanging and delivering signal in the server. This is a more efficient and cheap way for holding a small business, like a small restaurant. Instead of screaming out orders, running around to connect you customer with the cook, the waiters could simply stand by the customer, and elegantly controll everything on the screen.

This project is at very rudimentary level - a lot of methods and great ideas (well, I think...)  have not been implemented yet. I will keep working on this project, and hopefully it will contribute a little bit for the community.

## Run App Locally
By pushing a small piece of demo data (McDonald's dishes), it enable one run it locally without shiny server or shiny.io. You can try this our by follow the steps below:

* git clone the the project under a directory you know
```
git clone git@github.com:OrangePeelZ/makeYourOrders.git
```
* Open your Rstudio and install following packages in the console
```
install.packages(c("shiny", "shinydashboard", "dplyr"))
```
* Open `server.R` in Rstudio and click `Run` on the top right corner of your script screen.




## Authors

* **Xinyue Zhou** - *Initial work* - [OrangePeelZ](https://github.com/OrangePeelZ/)
