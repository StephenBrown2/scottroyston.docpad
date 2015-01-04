/* Your scripts go here */

// Internet Defense League Alert
    window._idl = {};
    _idl.variant = "modal";
    (function() {
        var idl = document.createElement('script');
        idl.type = 'text/javascript';
        idl.async = true;
        idl.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'members.internetdefenseleague.org/include/?url=' + (_idl.url || '') + '&campaign=' + (_idl.campaign || '') + '&variant=' + (_idl.variant || 'modal');
        document.getElementsByTagName('body')[0].appendChild(idl);
    })();

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
        }
    });

    $('#filters').on( 'click', 'button', function() {
      var filterValue = $(this).attr('data-filter');
        $container.isotope({ filter: filterValue });
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

// magnificPopup JS
    $('a.overlay').magnificPopup({
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
