		<!-- BEGIN HOME SLIDER SECTION -->
		<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
		  <!-- Indicators 
		  <ol class="carousel-indicators">
		    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
		    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
		  </ol> -->

		  <!-- Wrapper for slides -->
		  <div class="carousel-inner" role="listbox">
		    <div class="item active"id="slide1" style="background: url(http://placehold.it/1920x605) no-repeat left center; background-size: cover;"> <!-- Ready for JS Injection -->
		      <div class="carousel-caption">
				<div class="caption sfr slider-title">Breathtaking views</div>
				<div class="caption sfl slider-subtitle">Relaxation in the Bay of Belfalas</div>
				<a href="#" class="caption sfb btn btn-default btn-lg">Learn More</a>
		      </div>
		    </div>
		    <div class="item" id="slide2" style="background: url(http://placehold.it/1920x605) no-repeat left center; background-size: cover;"> 
		      <div class="carousel-caption">
				<div class="caption sfr slider-title">The simple life</div>
				<div class="caption sfl slider-subtitle">Lush gardens in Mordor</div>
				<a href="#" class="caption sfb btn btn-default btn-lg">Learn More</a>
		      </div>
		    </div>
		  </div>
		  <!-- Blue Filter -->
		  <div id="home-search-section"></div>

		  <!-- Controls -->
		  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
		    <span class="glyphicon glyphicon-chevron-left"></span>
		    <span class="sr-only">Previous</span>
		  </a>
		  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
		    <span class="glyphicon glyphicon-chevron-right"></span>
		    <span class="sr-only">Next</span>
		  </a>



		</div>		
		<!-- END HOME SLIDER SECTION -->
		
		<!-- BEGIN HOME ADVANCED SEARCH -->
		<div id="home-advanced-search" class="open">
			<div id="opensearch"></div>
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
						<form>
							<div class="form-group">
								<div class="form-control-small">
									<div class='input-group date chzn-container' data-datepicker>
										<input placeholder="Arrive on..." type='text' class="form-control" data-date-format="DD/MM/YYYY"/>
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
								
								<div class="form-control-small">
									<select id="search_status" name="search_status" data-placeholder="Stay...">
										<option value=""> </option>
										<option value="1">1 Night</option>
										<option value="2">2 Nights</option>
										<option value="3">3 Nights</option>
										<option value="4">4 Nights</option>
										<option value="5">5 Nights</option>
										<option value="6">6 Nights</option>
										<option value="7">7 Nights</option>
										<option value="8">8 Nights</option>
										<option value="9">9 Nights</option>
										<option value="10">10 Nights</option>
										<option value="11">11 Nights</option>
										<option value="12">12 Nights</option>
										<option value="13">13 Nights</option>
										<option value="14">14 Nights</option>
									</select>
								</div>
								
								<div class="form-control-small">
									<select id="search_bedrooms" name="search_bedrooms" data-placeholder="Bedrooms">
										<option value=""> </option>
										<option value="0">0</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="5plus">5+</option>
									</select>
								</div>
								<div class="form-control-large">
									<input type="text" class="form-control" name="location" placeholder="City, State, Country, etc...">
								</div>
								<button type="submit" class="btn btn-fullcolor">Search</button>
							</div>
						</form>

					</div>
				</div>
			</div>
		</div>
		<!-- END HOME ADVANCED SEARCH -->
		
		
		<!-- BEGIN CONTENT WRAPPER -->
		<div class="content">
			<div class="container">
				<div class="row">
				
					<!-- BEGIN MAIN CONTENT -->
					<div class="main col-sm-8">
						<h1 class="section-title">Featured Properties</h1>
						<div class="grid-style1 clearfix">
							<% loop $FeaturedProperties %>
                  <div class="item col-md-4">
                      <div class="image">
                          <a href="$Link">
                              <h3>$Title</h3>
                              <span class="location">$Region.Title</span>
                          </a>
												$PrimaryPhoto.Fill(220,194)
                      </div>
                      <div class="price">
                          <span>$PricePerNight.Nice</span><p>per night<p>
                      </div>
                      <ul class="amenities">
                          <li><i class="icon-bedrooms"></i> $Bedrooms</li>
                          <li><i class="icon-bathrooms"></i> $Bathrooms</li>
                      </ul>
                  </div>
							<% end_loop %>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<h1 class="section-title">Popular Regions</h1>
								<div id="regions">
									<div class="item">
										<a href="#">
											<img src="http://placehold.it/194x194" alt=""  />
											<h3>Rhovanion</h3>
										</a>
									</div>
									<div class="item">
										<a href="#">
											<img src="http://placehold.it/194x194" alt="" />
											<h3>Eriador</h3>
										</a>
									</div>
									<div class="item">
										<a href="#">
											<img src="http://placehold.it/194x194" alt=""  />
											<h3>Bay of Belfalas</h3>
										</a>
									</div>
									<div class="item">
										<a href="#">
											<img src="http://placehold.it/194x194" alt="" />
											<h3>Mordor</h3>
										</a>
									</div>

									<div class="item">
										<a href="#">
											<img src="http://placehold.it/194x194" alt=""  />
											<h3>The Southwest</h3>
										</a>
									</div>
									<div class="item">
										<a href="#">
											<img src="http://placehold.it/194x194" alt="" />
											<h3>Arnor</h3>
										</a>
									</div>
								</div>
								

							</div>
						</div>

						<h1 class="section-title">Recent Articles</h1>
						<div class="grid-style1">
							<% loop $LatestArticles(3) %>
									<div class="item col-md-4">
											<div class="image">
													<a href="$Link">
															<span class="btn btn-default"> Read More</span>
													</a>
												$Photo.Fit(220,148)
											</div>
											<div class="tag"><i class="fa fa-file-text"></i></div>
											<div class="info-blog">
													<ul class="top-info">
															<li><i class="fa fa-calendar"></i> $Date.Format('j F, Y')</li>
															<li><i class="fa fa-comments-o"></i> 2</li>
                              <li><i class="fa fa-tags"></i> $CategoriesList</li>
													</ul>
													<h3>
															<a href="$Link">$Title</a>
													</h3>
													<p><% if $Teaser %>$Teaser<% else %>$Content.FirstSentence<% end_if %></p>
											</div>
									</div>
							<% end_loop %>
						</div>
						<div class="center"><a href="#" class="btn btn-default-color">View All News</a></div>
					</div>
					<!-- END MAIN CONTENT -->
					
					<!-- BEGIN SIDEBAR -->
					<div class="sidebar col-sm-4">
						
						<!-- BEGIN SIDEBAR ABOUT -->
						<div class="col-sm-12">
							<h2 class="section-title">Last minute deals</h2>
							<ul class="latest-news">
							<li class="col-md-12">
								<div class="image">
									<a href="blog-detail.html"></a>
									<img alt="" src="http://placehold.it/100x100">
								</div>
								
								<ul class="top-info">
									<li><i class="fa fa-calendar"></i>Available Now</li>
								</ul>
									
								<h4><a href="blog-detail.html">Private Beach</a><p>Lossarnach, Eriado</p></h4>
							</li>
							<li class="col-md-12">
								<div class="image">
									<a href="blog-detail.html"></a>
									<img alt="" src="http://placehold.it/100x100">
								</div>
								
								<ul class="top-info">
									<li><i class="fa fa-calendar"></i>Available on 24 July</li>
								</ul>
									
								<h4><a href="blog-detail.html">Mountain views</a><p>Hyarnustar, Rhovanion</p></h4>
							</li>
							<li class="col-md-12">
								<div class="image">
									<a href="blog-detail.html"></a>
									<img alt="" src="http://placehold.it/100x100">
								</div>
								
								<ul class="top-info">
									<li><i class="fa fa-calendar"></i>Available 5 July</li>
								</ul>
								
								<h4><a href="blog-detail.html">Heart of the village</a><p>Minhiriath, Eriador</p></h4>
							</li>
							<li class="col-md-12">
								<div class="image">
									<a href="blog-detail.html"></a>
									<img alt="" src="http://placehold.it/100x100">
								</div>
								
								<ul class="top-info">
									<li><i class="fa fa-calendar"></i>Available 6 July</li>
								</ul>
								
                <h4><a href="blog-detail.html">The city life</a><p>West Beleriand, Mordor</p></h4>
							</li></ul>
							<p class="center"><a class="btn btn-fullcolor" href="#">More deals</a></p>
						</div>
						<!-- END SIDEBAR ABOUT -->
						
						
						<div class="col-sm-12">
							<h2 class="section-title">Activity</h2>
							<ul class="activity">
								<li class="col-lg-12">
									<a href="#"><img src="http://placehold.it/70x70" alt="" /></a>
									<div class="info">										
										<h5>Sam Minnée reviewed <a href="#">The House With No Windows</a></h4>
										<p>Awesome solitary confinement, mate. Spot on. Sweet as.</p>
										<h6>Just now</h6>
									</div>
								</li>
								<li class="col-lg-12">
									<a href="#"><img src="http://placehold.it/70x70" alt="" /></a>
									<div class="info">
										<h5>Ingo Schoomer asked a question about <a href="#">The Mistake by the Lake</a></h4>
										<p>Has this house been unit tested?</p>
										<h6>37 minutes ago</h6>
									</div>
								</li>
							</ul>
						</div>
						
						
						
					</div>
					<!-- END SIDEBAR -->
					
				</div>
			</div>
		</div>
		<!-- END CONTENT WRAPPER -->
