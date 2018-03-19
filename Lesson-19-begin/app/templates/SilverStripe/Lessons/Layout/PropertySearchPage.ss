
<!-- BEGIN CONTENT WRAPPER -->
<div class="content">
    <div class="container">
        <div class="row">

            <!-- BEGIN MAIN CONTENT -->
            <div class="main col-sm-8">
                <% include SilverStripe/Lessons/PropertySearchResults %>
            </div>
            <!-- END MAIN CONTENT -->


            <!-- BEGIN SIDEBAR -->
            <div class="sidebar gray col-sm-4">

                <!-- BEGIN ADVANCED SEARCH -->
                <h2 class="section-title">Search Property</h2>
                <% if $ActiveFilters %>
                <div class="chzn-container-multi">
                    <ul class="chzn-choices">
                        <% loop $ActiveFilters %>
                            <li class="search-choice"><span>$Label</span><a href="$RemoveLink" class="search-choice-close"></a></li>
                        <% end_loop %>
                    </ul>
                </div>
                <% end_if %>
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