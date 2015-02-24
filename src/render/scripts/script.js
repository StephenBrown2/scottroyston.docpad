/* Your scripts go here */

// Pull Nav function for mobile menu
    $(function() {
      var pull    = $('#pull');
        menu    = $('nav ul');
        menuHeight  = menu.height();

      $(pull).on('click', function(e) {
        e.preventDefault();
        menu.slideToggle();
      });

      $(window).resize(function(){
            var w = $(window).width();
            if(w > 320 && menu.is(':hidden')) {
              menu.removeAttr('style');
            }
        });
    });

// Isotope JS
    var $container = $('.isotope'),
        qsRegex,
        filters = {};
    $container.isotope({
        itemSelector: '.art',
        masonry: {
            columnWidth: '.grid-sizer',
            gutter: '.gutter-sizer',
        },
        sortBy: 'random',
        getSortData: {
            title: '[data-title]',
        },
       // isInitLayout: false
    });

/*elements = [];

    $container.isotope( 'on', 'layoutComplete',
        function( isoInstance, laidOutItems ) {
            elements = laidOutItems.map(function(item) {
                return item.element;
            })
            console.log( elements );
        }
    );
*/
/*
    $container.isotope( 'on', 'layoutComplete',
        function( isoInstance, laidOutItems ) {
            for (var i = 0; i < laidOutItems.length; i++ ) {
              item = laidOutItems[i];
              console.log( item['element'] );
            }
        }
    );
*/
//    $container.isotope();

    // use value of search field to filter
    var $quicksearch = $('#quicksearch').keyup(debounce(searchFilter));

    function searchFilter() {
        qsRegex = new RegExp($quicksearch.val(), 'gi');
        $container.isotope({
            filter: function () {
                return qsRegex ? $(this).text().match(qsRegex) : true;
            }
        });
    }


    function debounce(fn, threshold) {
        var timeout;
        return function debounced() {
            if (timeout) {
                clearTimeout(timeout);
            }

            function delayed() {
                fn();
                timeout = null;
            }
            setTimeout(delayed, threshold || 100);
        }
    }

    $('#filters').on( 'click', 'button', function() {
      var filterValue = $(this).attr('data-filter');
        $container.isotope({ filter: filterValue });
    });

// magnificPopup JS
    $('a.overlay').magnificPopup({
        delegate: 'a.overlay:not(.isotope-hidden)',
        type:'image',
        image: {
            titleSrc: 'data-title',
        },
        gallery: {
            enabled: true,
            preload: [1,2],
        },
        /*disableOn: function() {
            if( $(window).width() < 480 ) {
                return false;
            } else {
                return true;
            }
        },*/
    });
