# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {

    # =================================
    # Plugin Configuration

    plugins:
        imagin:
            presets:
                'default':
                    w: 200
                    h: 200
                    q: 90
                'small':
                    w: 100
                    h: 100
                'medium':
                    w: 300
                    h: 1024
                'large':
                    w: 500
                    h: 500
        coffeemugg:
            options:
                format: true
        ghpages:
            deployRemote: 'origin'
            deployBranch: 'dploy'

    # =================================
    # Template Data
    # These are variables that will be accessible via our templates
    # To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

    templateData:

        # Specify some site properties
        site:
            # The production url of our website
            # If not set, will default to the calculated site URL (e.g. http://localhost:9778)
            url: "http://scottroyston.com"

            # Here are some old site urls that you would like to redirect from
            oldUrls: [
                'www.scottroyston.com',
                'ssl.scottroyston.com'
            ]

            # The default title of our website
            title: "Scott Royston"

            # The website description (for SEO)
            description: """
                A Dutch Old Master Still Life Artist, Scott B. Royston, OPA, has been showing his oil paintings in galleries and juried exhibitions since 1993.
                He has received numerous awards and honors for his work and was recently accepted as an Elected Member of the Allied Artists of America, Inc.
                """

            # The website keywords (for SEO) separated by commas
            keywords: """
                """

            # The website's styles
            styles: [
                '/vendor/normalize.css'
                '/vendor/h5bp.css'
                '/vendor/magnific-popup.css'
                '/styles/style.css'
                '/styles/art.css'
            ]

            # The website's scripts
            scripts: [
                """
                <!-- jQuery -->
                <script type="text/javascript" src="//code.jquery.com/jquery-2.1.0.js"></script>
                <script>window.jQuery || document.write('<script type="text/javascript" src="/vendor/jquery.js"><\\/script>')</script>
                """

                '/vendor/log.js'
                '/vendor/modernizr.js'
                '/vendor/isotope.js'
                '/vendor/magnific-popup.js'
                '/scripts/script.js'
            ]

            themeBgColor: "#498283"

        # -----------------------------
        # Helper Functions

        # Get the prepared site/document title
        # Often we would like to specify particular formatting to our page's title
        # we can apply that formatting here
        getPreparedTitle: ->
            # if we have a document title, then we should use that and suffix the site's title onto it
            if @['document'].title
                "#{@document.title} | #{@site.title}"
            # if our document does not have it's own title, then we should just use the site's title
            else
                @site.title

        # Get the prepared site/document description
        getPreparedDescription: ->
            # if we have a document description, then we should use that, otherwise use the site's description
            @document.description or @site.description

        # Get the prepared site/document keywords
        getPreparedKeywords: ->
            # Merge the document keywords with the site keywords
            @site.keywords.concat(@document.keywords or []).join(', ')

        getData: (dataKey) =>
            @data["#{dataKey}"].toJSON()

        getTitleCap: (titleString) ->
            capitalize = require('title-capitalization')
            return capitalize(titleString.toString())

    # =================================
    # Collections

    # Here we define our custom collections
    # What we do is we use findAllLive to find a subset of documents from the parent collection
    # creating a live collection out of it
    # A live collection is a collection that constantly stays up to date
    # You can learn more about live collections and querying via
    # http://bevry.me/queryengine/guide

    collections:

        # Create a collection called posts
        # That contains all the documents that will be going to the out path posts
        topNav: ->
            @getCollection('documents').findAllLive({topNav: true})


    # =================================
    # Environments

    # DocPad's default environment is the production environment
    # The development environment, actually extends from the production environment

    # The following overrides our production url in our development environment with false
    # This allows DocPad's to use it's own calculated site URL instead, due to the falsey value
    # This allows <%- @site.url %> in our template data to work correctly, regardless what environment we are in

    environments:
        development:
            templateData:
                site:
                    url: false


    # =================================
    # DocPad Events

    # Here we can define handlers for events that DocPad fires
    # You can find a full listing of events on the DocPad Wiki

    events:

        # Server Extend
        # Used to add our own custom routes to the server before the docpad routes are added
        serverExtend: (opts) ->
            # Extract the server from the options
            {server} = opts
            docpad = @docpad

            # As we are now running in an event,
            # ensure we are using the latest copy of the docpad configuraiton
            # and fetch our urls from it
            latestConfig = docpad.getConfig()
            oldUrls = latestConfig.templateData.site.oldUrls or []
            newUrl = latestConfig.templateData.site.url

            # Redirect any requests accessing one of our sites oldUrls to the new site url
            server.use (req,res,next) ->
                if req.headers.host in oldUrls
                    res.redirect(newUrl+req.url, 301)
                else
                    next()

    regenerateDelay: 10    # default: 100

}

# Export our DocPad Configuration
module.exports = docpadConfig
