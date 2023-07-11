
I've chosen to make use of MVVM pattern in this project.

To get a nicely looking list of cats with its info, the challenge was to choose a layout that was suitable and scalable (for iPad / Mac) When choosing a tableView for the list, that would be less easy scalable. CollectionView can easily be adjusted to present the view as desired for different devices and orientations. 

To speed up the game, I've made use of Snapkit, which makes it a lot easiers to apply constraints to views and also increases readability. The package is still maintained, which was a prerequisite for me.

I was able to quickly implement the basic list due to components that I could reuse from my previous projects, but the implementation of the collection view was time intensive so I run out of time for test implementations.

That said, to implement the collection view I wanted a simple view as POC. For the cat model I implemented a limited set of properties as a POC but kept it like that due to time constraints. Also the card itself is very basic. When added more properties, a segmentation would probably look better.

I made use of the progressView, which looks ok, but probably not the best pick for visual presentation.

I have some todos which could not be implemented due to lack of time, but wanted to implement an alert presenter for testing of the presenting of an alert and handle of actions.
