# Pokemon Demo
Fetching pokemons' data from remote server and render on a listview with clicking on each item navigating to pokemon detail page. Developed with flutter. 

The flutter version is 3.3.8

As there is no option for pagination existed on graphql API except only fetcing first n number items, I have applied a technique which plays like while scrolling on the screen the "first" value will be increased by number 10 each time you scrolled to the max position of screen. I have used this technique for a smooth listview and as one can show all the pokemons by scrolling.

For calling GraphQL API I have used graphql_flutter package and have maintained state through provider class.

I have added a simple splash screen, and designed the overall app simply, using attractive, sound visible i.e. eye comfort colors.

