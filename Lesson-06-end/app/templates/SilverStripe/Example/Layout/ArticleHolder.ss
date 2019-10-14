<div class="parallax colored-bg pattern-bg" data-stellar-background-ratio="0.5">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <h1 class="page-title">Blog Listing 4</h1>

                <div class="breadcrumb">
                    <a href="#">Home </a> &raquo;
                    <a href="#">Travel Guides</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END PAGE TITLE/BREADCRUMB -->


<!-- BEGIN CONTENT WRAPPER -->
<div class="content">
    <div class="container">
        <div class="row">

            <!-- BEGIN MAIN CONTENT -->
            <div class="main col-sm-8">


                <div id="blog-listing" class="list-style clearfix">
                    <div class="row">
                        <% loop $Children %>
                            <div class="item col-md-6">
                                <div class="image">
                                    <a href="$Link">
                                        <span class="btn btn-default">Read More</span>
                                    </a>
                                    <img src="http://placehold.it/766x515" alt="" />
                                </div>
                                <div class="tag"><i class="fa fa-file-text"></i></div>
                                <div class="info-blog">
                                    <ul class="top-info">
                                        <li><i class="fa fa-calendar"></i> $Date.Long</li>
                                        <li><i class="fa fa-comments-o"></i> 2</li>
                                        <li><i class="fa fa-tags"></i> Properties, Prices, best deals</li>
                                    </ul>
                                    <h3>
                                        <a href="$Link">$Title</a>
                                    </h3>
                                    <% if $Teaser %>
                                        <p>$Teaser</p>
                                    <% else %>
                                        <p>$Content.FirstSentence</p>
                                    <% end_if %>
                                </div>
                            </div>
                        <% end_loop %>
                    </div>
                </div>


                <!-- BEGIN PAGINATION -->
                <div class="pagination">
                    <ul id="previous">
                        <li><a href="#"><i class="fa fa-chevron-left"></i></a></li>
                    </ul>
                    <ul>
                        <li class="active"><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                    </ul>
                    <ul id="next">
                        <li><a href="#"><i class="fa fa-chevron-right"></i></a></li>
                    </ul>
                </div>
                <!-- END PAGINATION -->

            </div>
            <!-- END MAIN CONTENT -->


            <!-- BEGIN SIDEBAR -->
            <div class="sidebar gray col-sm-4">

                <h2 class="section-title">Categories</h2>
                <ul class="categories">
                    <li><a href="#">Business <span>(2)</span></a></li>
                    <li><a href="#">Commercial <span>(1)</span></a></li>
                    <li><a href="#">Land <span>(3)</span></a></li>
                    <li><a href="#">Loans <span>(2)</span></a></li>
                    <li><a href="#">News and Updates <span>(6)</span></a></li>
                    <li><a href="#">Properties for Sale <span>(1)</span></a></li>
                    <li><a href="#">Real Estate <span>(1)</span></a></li>
                </ul>

                <!-- BEGIN ARCHIVES ACCORDION -->
                <h2 class="section-title">Archives</h2>
                <div id="accordion" class="panel-group blog-accordion">
                    <div class="panel">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="">
                                    <i class="fa fa-chevron-right"></i> 2014 (15)
                                </a>
                            </div>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <ul>
                                    <li><a href="#">July (3)</a></li>
                                    <li><a href="#">June (4)</a></li>
                                    <li><a href="#">May (1)</a></li>
                                    <li><a href="#">April (2)</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="panel">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="collapsed">
                                    <i class="fa fa-chevron-right"></i> 2013 (6)
                                </a>
                            </div>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse">
                            <div class="panel-body">
                                <ul>
                                    <li><a href="#">May (1)</a></li>
                                    <li><a href="#">April (2)</a></li>
                                    <li><a href="#">March (1)</a></li>
                                    <li><a href="#">February (2)</a></li>
                                    <li><a href="#">January (1)</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="panel">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" class="collapsed">
                                    <i class="fa fa-chevron-right"></i> 2012 (5)
                                </a>
                            </div>
                        </div>
                        <div id="collapseThree" class="panel-collapse collapse">
                            <div class="panel-body">
                                <ul>
                                    <li><a href="#">April (1)</a></li>
                                    <li><a href="#">March (1)</a></li>
                                    <li><a href="#">February (2)</a></li>
                                    <li><a href="#">January (1)</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END  ARCHIVES ACCORDION -->


                <!-- BEGIN TAGS -->
                <h2 class="section-title">Tags</h2>
                <ul class="tags col-sm-12">
                    <li><a href="#">Apartments</a></li>
                    <li><a href="#">Residential</a></li>
                    <li><a href="#">News</a></li>
                    <li><a href="#">Real estate</a></li>
                    <li><a href="#">Land</a></li>
                    <li><a href="#">Business</a></li>
                    <li><a href="#">Villas</a></li>
                    <li><a href="#">Loans</a></li>
                    <li><a href="#">Commercial</a></li>
                    <li><a href="#">Rent</a></li>
                </ul>
                <!-- BEGIN TAGS -->


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

                        <h3><a href="blog-detail.html">How to get your dream property for the best price?</a></h3>
                    </li>
                    <li class="col-md-12">
                        <div class="image">
                            <a href="blog-detail.html"></a>
                            <img src="http://placehold.it/100x100" alt="" />
                        </div>

                        <ul class="top-info">
                            <li><i class="fa fa-calendar"></i> July 24, 2014</li>
                        </ul>

                        <h3><a href="blog-detail.html">7 tips to get the best mortgage.</a></h3>
                    </li>
                    <li class="col-md-12">
                        <div class="image">
                            <a href="blog-detail.html"></a>
                            <img src="http://placehold.it/100x100" alt="" />
                        </div>

                        <ul class="top-info">
                            <li><i class="fa fa-calendar"></i> July 05, 2014</li>
                        </ul>

                        <h3><a href="blog-detail.html">House, location or price: What's the most important factor?</a></h3>
                    </li>
                </ul>
                <!-- END LATEST NEWS -->

            </div>
            <!-- END SIDEBAR -->

        </div>
    </div>
</div>
