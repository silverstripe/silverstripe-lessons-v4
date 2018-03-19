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
							<div class="item col-md-4">
								<div class="image">
									<a href="properties-detail.html">
										<h3>Luxury Apartment with great views</h3>
										<span class="location">Upper East Side, New York</span>
									</a>
									<img src="http://placehold.it/760x670" alt="" />
								</div>
								<div class="price">
									<span>$950</span><p>per night<p>
								</div>
								<ul class="amenities">
									<li><i class="icon-bedrooms"></i> 4</li>
									<li><i class="icon-bathrooms"></i> 3</li>
								</ul>
							</div>
							
							<div class="item col-md-4">
								<div class="image">
									<a href="properties-detail.html">
										<h3>Stunning Villa with 5 bedrooms</h3>
										<span class="location">Miami Beach, Florida</span>
									</a>
									<img src="http://placehold.it/760x670" alt="" />
								</div>
								<div class="price">
									<span>$1,300</span><p>per night<p>
								</div>
								<ul class="amenities">
									<li><i class="icon-bedrooms"></i> 5</li>
									<li><i class="icon-bathrooms"></i> 2</li>
								</ul>
							</div>
							
							<div class="item col-md-4">
								<div class="image">
									<a href="properties-detail.html">
										<h3>Recent construction with 3 bedrooms</h3>
										<span class="location">Park Slope, New York</span>
									</a>
									<img src="http://placehold.it/760x670" alt="" />
								</div>
								<div class="price">
									<span>$560</span><p>per night<p>
								</div>
								<ul class="amenities">
									<li><i class="icon-bedrooms"></i> 3</li>
									<li><i class="icon-bathrooms"></i> 2</li>
								</ul>
							</div>
							
							<div class="item col-md-4">
								<div class="image">
									<a href="properties-detail.html">
										<h3>Modern construction with parking space</h3>
										<span class="location">Midtown, New York</span>
									</a>
									<img src="http://placehold.it/760x670" alt="" />
								</div>
								<div class="price">
									<span>$85</span><p>per night<p>
								</div>
								<ul class="amenities">
									<li><i class="icon-bedrooms"></i> 1</li>
									<li><i class="icon-bathrooms"></i> 2</li>
								</ul>
							</div>
							
							<div class="item col-md-4">
								<div class="image">
									<a href="properties-detail.html">
										<h3>Single Family Townhouse</h3>
										<span class="location">Cobble Hill, New York</span>
									</a>
									<img src="http://placehold.it/760x670" alt="" />
								</div>
								<div class="price">									
									<span>$840</span><p>per night<p>
								</div>
								<ul class="amenities">
									<li><i class="icon-bedrooms"></i> 2</li>
									<li><i class="icon-bathrooms"></i> 2</li>
								</ul>
							</div>
							
							<div class="item col-md-4">
								<div class="image">
									<a href="properties-detail.html">
										<h3>3 bedroom villa with garage for rent</h3>
										<span class="location">Bal Harbour, Florida</span>
									</a>
									<img src="http://placehold.it/760x670" alt="" />
								</div>
								<div class="price">									
									<span>$150</span><p>per night<p>
								</div>
								<ul class="amenities">
									<li><i class="icon-bedrooms"></i> 3</li>
									<li><i class="icon-bathrooms"></i> 2</li>
								</ul>
							</div>
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
							<div class="item col-md-4">
								<div class="image">
									<a href="#">
										<span class="btn btn-default"><i class="fa fa-file-o"></i> Read More</span>
									</a>
									<img src="http://placehold.it/766x515" alt="" />
								</div>
								<div class="tag"><i class="fa fa-file-text"></i></div>
								<div class="info-blog">
									<ul class="top-info">
										<li><i class="fa fa-calendar"></i> July 30, 2014</li>
										<li><i class="fa fa-comments-o"></i> 2</li>
										<li><i class="fa fa-tags"></i> Properties, Prices, best deals</li>
									</ul>
									<h3>
										<a href="#">How to get your dream property for the best price?</a>
									</h3>
									<p>Sed rutrum urna id tellus euismod gravida. Praesent placerat, mauris ac pellentesque fringilla, tortor libero condimen.</p>
								</div>
							</div>
							<div class="item col-md-4">
								<div class="image">
									<a href="#">
										<span class="btn btn-default"><i class="fa fa-file-o"></i> Read More</span>
									</a>
									<img src="http://placehold.it/766x515" alt="" />
								</div>
								<div class="tag"><i class="fa fa-film"></i></div>
								<div class="info-blog">
									<ul class="top-info">
										<li><i class="fa fa-calendar"></i> July 24, 2014</li>
										<li><i class="fa fa-comments-o"></i> 4</li>
										<li><i class="fa fa-tags"></i> Tips, Mortgage</li>
									</ul>
									<h3>
										<a href="#">7 tips to get the best mortgage.</a>
									</h3>
									<p>Sed rutrum urna id tellus euismod gravida. Praesent placerat, mauris ac pellentesque fringilla, tortor libero condimen.</p>
								</div>
							</div>
							<div class="item col-md-4">
								<div class="image">
									<a href="#">
										<span class="btn btn-default"><i class="fa fa-file-o"></i> Read More</span>
									</a>
									<img src="http://placehold.it/766x515" alt="" />
								</div>
								<div class="tag"><i class="fa fa-file-text"></i></div>
								<div class="info-blog">
									<ul class="top-info">
										<li><i class="fa fa-calendar"></i> July 05, 2014</li>
										<li><i class="fa fa-comments-o"></i> 1</li>
										<li><i class="fa fa-tags"></i> Location, Price, House</li>
									</ul>
									<h3>
										<a href="#">House, location or price: What's the most important factor?</a>
									</h3>
									<p>Sed rutrum urna id tellus euismod gravida. Praesent placerat, mauris ac pellentesque fringilla, tortor libero condimen.</p>
								</div>
							</div>
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
