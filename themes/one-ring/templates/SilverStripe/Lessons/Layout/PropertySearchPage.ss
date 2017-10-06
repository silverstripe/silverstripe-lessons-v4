
<!-- BEGIN CONTENT WRAPPER -->
<div class="content">
    <div class="container">
        <div class="row">

            <!-- BEGIN MAIN CONTENT -->
            <div class="main col-sm-8">

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

            </div>
            <!-- END MAIN CONTENT -->


            <!-- BEGIN SIDEBAR -->
            <div class="sidebar gray col-sm-4">

                <!-- BEGIN ADVANCED SEARCH -->
                <h2 class="section-title">Search Property</h2>
                <div class="chzn-container-multi">
                    <ul class="chzn-choices">
                        <li class="search-choice"><span>New York</span><a href="#" class="search-choice-close"></a></li>
                        <li class="search-choice"><span>Residential</span><a href="#" class="search-choice-close"></a></li>
                        <li class="search-choice"><span>3 bedrooms</span><a href="#" class="search-choice-close"></a></li>
                        <li class="search-choice"><span>2 bathrooms</span><a href="#" class="search-choice-close"></a></li>
                        <li class="search-choice"><span>Min. $150</span><a href="#" class="search-choice-close"></a></li>
                        <li class="search-choice"><span>Min. $400</span><a href="#" class="search-choice-close"></a></li>
                    </ul>
                </div>
                $PropertySearchForm
                <!-- END ADVANCED SEARCH -->

                <!-- BEGIN LATEST NEWS -->
                <h2 class="section-title">Latest News</h2>
                <ul class="latest-news">
                    <li class="col-md-12">
                        <div class="image">
                            <a href="blog-detail.html"></a>
                            <img src="http://placehold.it/100x100" alt="" />
                        </div>

                        <ul class="top-info">
                            <li><i class="fa fa-calendar"></i> July 30, 2014</li>
                        </ul>

                        <h4><a href="blog-detail.html">How to get your dream property for the best price?</a></h4>
                    </li>
                    <li class="col-md-12">
                        <div class="image">
                            <a href="blog-detail.html"></a>
                            <img src="http://placehold.it/100x100" alt="" />
                        </div>

                        <ul class="top-info">
                            <li><i class="fa fa-calendar"></i> July 24, 2014</li>
                        </ul>

                        <h4><a href="blog-detail.html">7 tips to get the best mortgage.</a></h4>
                    </li>
                    <li class="col-md-12">
                        <div class="image">
                            <a href="blog-detail.html"></a>
                            <img src="http://placehold.it/100x100" alt="" />
                        </div>

                        <ul class="top-info">
                            <li><i class="fa fa-calendar"></i> July 05, 2014</li>
                        </ul>

                        <h4><a href="blog-detail.html">House, location or price: What's the most important factor?</a></h4>
                    </li>
                </ul>
                <!-- END LATEST NEWS -->

                <!-- BEGIN NEWSLETTER -->
                <div id="newsletter" class="col-sm-12">
                    <h2 class="section-title">Subscribe our weekly<br><span>Newsletter</span></h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit lorem ipsum dolor sit amet consectetur adipiscing elit.</p>

                    <div class="input-group">
                        <input type="text" placeholder="Enter your E-mail" name="newsletter_email" id="newsletter_email" class="form-control" />
                        <span class="input-group-btn">
							<button class="btn btn-default-color" type="button">Subscribe</button>
						</span>
                    </div>
                </div>
                <!-- END NEWSLETTER -->

            </div>
            <!-- END SIDEBAR -->

        </div>
    </div>
</div>
<!-- END CONTENT WRAPPER -->