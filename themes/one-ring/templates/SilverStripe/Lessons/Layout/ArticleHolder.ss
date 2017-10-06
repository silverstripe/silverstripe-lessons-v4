<% include Banner %>
<!-- BEGIN CONTENT WRAPPER -->
<div class="content">
	<div class="container">
		<div class="row">
		
			<!-- BEGIN MAIN CONTENT -->
			<div class="main col-sm-8">
				<div id="blog-listing" class="list-style clearfix">
					<div class="row">
						 <% if $SelectedRegion %>
								<h3>Region: $SelectedRegion.Title</h3>
						 <% else_if $SelectedCategory %>
								<h3>Category: $SelectedCategory.Title</h3>
						 <% else_if $StartDate %>
                 <h3>Showing $StartDate.Date to $EndDate.Date</h3>
						 <% end_if %>
					   <% loop $PaginatedArticles %>
					    <div class="item col-md-6">
					      <div class="image">
					        <a href="$Link"> 
					          <span class="btn btn-default">Read More</span>
					        </a>
					        $Photo.Fit(242,156)					        
					      </div> <div class="tag"><i class="fa fa-file-text"></i></div>
								<div class="info-blog">
									<ul class="top-info">
										<li><i class="fa fa-calendar"></i> $Date.Nice</li>
										<li><i class="fa fa-comments-o"></i> 2</li>
										<li><i class="fa fa-tags"></i> $CategoriesList</li>
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
              <!-- BEGIN PAGINATION -->
						<% if $PaginatedArticles.MoreThanOnePage %>
                <div class="pagination">
									<% if $PaginatedArticles.NotFirstPage %>
                      <ul id="previous col-xs-6">
                          <li><a href="$PaginatedArticles.PrevLink"><i class="fa fa-chevron-left"></i></a></li>
                      </ul>
									<% end_if %>
                    <ul class="hidden-xs">
											<% loop $PaginatedArticles.PaginationSummary %>
												<% if $Link %>
                            <li <% if $CurrentBool %>class="active"<% end_if %>>
                                <a href="$Link">$PageNum</a>
                            </li>
												<% else %>
                            <li>...</li>
												<% end_if %>
											<% end_loop %>
                    </ul>
									<% if $PaginatedArticles.NotLastPage %>
                      <ul id="next col-xs-6">
                          <li><a href="$PaginatedArticles.NextLink"><i class="fa fa-chevron-right"></i></a></li>
                      </ul>
									<% end_if %>
                </div>
						<% end_if %>
              <!-- END PAGINATION -->
					</div>	
				</div>
			</div>
			<!-- END MAIN CONTENT -->

			<!-- BEGIN SIDEBAR -->
      <div class="sidebar gray col-sm-4">
				<h2 class="section-title">Categories</h2>
				<ul class="categories">
					<% loop $Categories %>
							<li><a href="$Link">$Title <span>($Articles.count)</span></a></li>
					<% end_loop %>
				</ul>
          <!-- BEGIN ARCHIVES ACCORDION -->
          <h2 class="section-title">Archives</h2>
          <div id="accordion" class="panel-group blog-accordion">
              <div class="panel">
                  <!--
                    <div class="panel-heading">
                      <div class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="">
                          <i class="fa fa-chevron-right"></i> 2014 (15)
                        </a>
                      </div>
                    </div>
                  -->
                  <div id="collapseOne" class="panel-collapse collapse in">
                      <div class="panel-body">
                          <ul>
														<% loop $ArchiveDates %>
                                <li><a href="$Link">$MonthName $Year ($ArticleCount)</a></li>
														<% end_loop %>
                          </ul>
                      </div>
                  </div>
              </div>
          </div>
          <!-- END  ARCHIVES ACCORDION -->

				<h2 class="section-title">Regions</h2>
				<ul class="categories">
					<% loop $Regions %>
							<li><a href="$ArticlesLink">$Title <span>($Articles.count)</span></a></li>
					<% end_loop %>
				</ul>

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
