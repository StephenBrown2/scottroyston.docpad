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

// Legacy Isotope JS
    var $oldcontainer = $('.oldisotope');

    $oldcontainer.isotope({
        itemSelector: '.oldart',
        masonry: {
            columnWidth: 250,
        },
        sortBy: 'sdate',
        sortAscending: false,
        getSortData: {
            sdate: '[data-sort]',
        },
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
        sortBy: 'sdate',
        sortAscending: false,
        getSortData: {
            title: '[data-title]',
            sdate: '[data-sort-date]',
        },
        isInitLayout: false
    });

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
    $('.wrapper').magnificPopup({
        delegate: 'a.overlay:visible',
        type:'image',
        image: {
            titleSrc: 'data-title',
        },
        gallery: {
            enabled: false,
            preload: [1,2],
        },
    });

    $('.oldwrapper a.old').magnificPopup({
        type:'image',
        gallery: {
            enabled: true,
            preload: [1,2],
        },
    });

$(window).load(function(){
   $container.isotope({
      isInitLayout: true
   });
});
