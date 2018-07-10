GB API
======
https://secure.gunzblazingpromo.com/gbpapi/api/v1/

Endpoints
---------
- /packs
  Returns an array of pack objects wrapped with response data
  {count: #, page: #, total: #, result:[]}
- /packs/:id
  Returns a singular pack object with the packid :id
- /sites
  Returns an array of site objects wrapped with response data
  {count: #, page: #, total: #, result:[]}
- /sites/:id
  Returns a singular site object with the paysiteid :id

Pagination
----------
Pagination is handled with the passing of query values of 'count'
and 'page'.
(e.g. https://secure.gunzblazingpromo.com/gbpapi/api/v1/sites?count=3&page=4)
Page length defaults to 1000 as it cannot easily output the
full response of packs....

Filtering
---------
Filtering is handled with the passing of query values in a 'filter'
namespace.
(e.g. https://secure.gunzblazingpromo.com/gbpapi/api/v1/sites?filter[shortname]=gdvd)
This does '$col LIKE %$val%' style comparisons and is limited
to the column names in the output.

Sorting
-------
Filtering is handled with the passing of query values in a 'sorting'
namespace.
(e.g. https://secure.gunzblazingpromo.com/gbpapi/api/v1/sites?sorting[shortname]=asc)