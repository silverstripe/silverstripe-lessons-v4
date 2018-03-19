
<div id="listing-header" class="clearfix">
    <div class="form-control-small">
        <select id="sort_by" name="sort_by" data-placeholder="Sort by">
            <option value=""> </option>
            <option value="data">Sort by Date</option>
            <option value="area">Sort by Area</option>
        </select>
    </div>

    <div class="sort">
        <ul>
            <li class="active"><i data-toggle="tooltip" data-placement="top" title="Sort Descending" class="fa fa-chevron-down"></i></li>
            <li><i data-toggle="tooltip" data-placement="top" title="Sort Ascending" class="fa fa-chevron-up"></i></li>
        </ul>
    </div>

    <div class="view-mode">
        <span>View Mode:</span>
        <ul>
            <li data-view="grid-style1" data-target="property-listing"><i class="fa fa-th"></i></li>
            <li data-view="list-style" data-target="property-listing" class="active"><i class="fa fa-th-list"></i></li>
        </ul>
    </div>
</div>

<!-- BEGIN PROPERTY LISTING -->
<div id="property-listing" class="list-style clearfix"> <!-- Inject "grid-style1" for grid view-->
  <% if $Results %>
      <h3>Showing $Results.PageLength results ($Results.getTotalItems total)</h3>
    <% loop $Results %>
        <div class="item col-md-4">
            <div class="image">
                <a href="$Link">
                    <span class="btn btn-default"><i class="fa fa-file-o"></i> Details</span>
                </a>
              $PrimaryPhoto.Fill(760,670)
            </div>
            <div class="price">
                <span>$PricePerNight.Nice</span><p>per night<p>
            </div>
            <div class="info">
                <h3>
                    <a href="$Link">$Title</a>
                    <small>$Region.Title</small>
                    <small>Available $AvailableStart.Nice - $AvailableEnd.Nice</small>
                </h3>
                <p>$Description.LimitSentences(3)</p>

                <ul class="amenities">
                    <li><i class="icon-bedrooms"></i> $Bedrooms</li>
                    <li><i class="icon-bathrooms"></i> $Bathrooms</li>
                </ul>
            </div>
        </div>
    <% end_loop %>
  <% end_if %>
</div>
<!-- END PROPERTY LISTING -->


<!-- BEGIN PAGINATION -->
<% if $Results.MoreThanOnePage %>
    <div class="pagination">
      <% if $Results.NotFirstPage %>
          <ul id="previous col-xs-6">
              <li><a href="$Results.PrevLink"><i class="fa fa-chevron-left"></i></a></li>
          </ul>
      <% end_if %>
        <ul class="hidden-xs">
          <% loop $Results.PaginationSummary %>
            <% if $Link %>
                <li <% if $CurrentBool %>class="active"<% end_if %>><a href="$Link">$PageNum</a></li>
            <% else %>
                <li>...</li>
            <% end_if %>
          <% end_loop %>
        </ul>
      <% if $Results.NotLastPage %>
          <ul id="next col-xs-6">
              <li><a href="$Results.NextLink"><i class="fa fa-chevron-right"></i></a></li>
          </ul>
      <% end_if %>
    </div>
<% end_if %>
<!-- END PAGINATION -->

