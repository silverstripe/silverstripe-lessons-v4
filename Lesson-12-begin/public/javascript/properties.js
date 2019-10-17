//List of properties
var properties = [
	{
		"id": 0,
		"title": "Luxury Apartment with great views",
		"latitude":40.727815,
		"longitude":-73.993544,
		"image":"http://placehold.it/760x670",
		"description":"Lafayette St New York, NY <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	},
	{
		"id": 1,
		"title": "Stunning Villa with 5 bedrooms",
		"latitude":40.730241,
		"longitude":-73.986664,
		"image":"http://placehold.it/760x670",
		"description":"2nd Ave, New York, NY <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-commercial.png"
	},
	{
		"id": 2,
		"title": "Property 3",
		"latitude":40.728645,
		"longitude":-73.987860,
		"image":"http://placehold.it/760x670",
		"description":"St Marks Pl, New York, NY <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-commercial.png"
	},
	{
		"id": 3,
		"title": "Property 4",
		"latitude":40.729262,
		"longitude":-73.989271,
		"image":"http://placehold.it/760x670",
		"description":"St Marks Pl New York, NY <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	},
	{
		"id": 4,
		"title": "Property 5",
		"latitude":40.728577,
		"longitude":-73.990629,
		"image":"http://placehold.it/760x670",
		"description":"Cooper Square, New York, NY <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	},
	{
		"id": 5,
		"title": "Property 6",
		"latitude":40.729930,
		"longitude":-73.992967,
		"image":"http://placehold.it/760x670",
		"description":"Broadway, New York, NY <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	},
	{
		"id": 6,
		"title": "Property 7",
		"latitude":25.791758,
		"longitude":-80.140058,
		"image":"http://placehold.it/760x670",
		"description":"Lenox Ave, Miami Beach, FL <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	},
	{
		"id": 7,
		"title": "Property 8",
		"latitude":25.791419,
		"longitude": -80.131935,
		"image":"http://placehold.it/760x670",
		"description":"Washington Ave, Miami Beach, FL <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-commercial.png"
	},
	{
		"id": 8,
		"title": "Property 9",
		"latitude":25.792987,
		"longitude": -80.134960,
		"image":"http://placehold.it/760x670",
		"description":"Convention Center Dr, Miami Beach, FL <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-commercial.png"
	},
	{
		"id": 9,
		"title": "Property 10",
		"latitude":38.850123,
		"longitude": -104.803812,
		"image":"http://placehold.it/760x670",
		"description":"Uintah St, Colorado Springs, CO <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-land.png"
	},
	{
		"id": 10,
		"title": "Property 11",
		"latitude":38.852373,
		"longitude": -104.790676,
		"image":"http://placehold.it/760x670",
		"description":"Swope Ave, Colorado Springs, CO <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	},
	{
		"id": 11,
		"title": "Property 12",
		"latitude":37.790236,
		"longitude": -122.407935,
		"image":"http://placehold.it/760x670",
		"description":"Bush St, San Francisco, CA <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	},
	{
		"id": 12,
		"title": "Property 13",
		"latitude":37.792401,
		"longitude": -122.404370,
		"image":"http://placehold.it/760x670",
		"description":"Kearny St, San Francisco, CA <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-commercial.png"
	},
	{
		"id": 13,
		"title": "Property 14",
		"latitude":37.792905,
		"longitude": -122.410229,
		"image":"http://placehold.it/760x670",
		"description":"Sacramento St, San Francisco, CA <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-commercial.png"
	},
	{
		"id": 14,
		"title": "Property 15",
		"latitude":37.792486,
		"longitude": -122.406139,
		"image":"http://placehold.it/760x670",
		"description":"Sacramento St, San Francisco, CA <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	},
	{
		"id": 15,
		"title": "Property 16",
		"latitude":37.795108,
		"longitude": -122.400364,
		"image":"http://placehold.it/760x670",
		"description":"California St, San Francisco, CA <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	},
	{
		"id": 16,
		"title": "Property 17",
		"latitude":36.139670,
		"longitude": -86.786006,
		"image":"http://placehold.it/760x670",
		"description":"11th Ave S, Nashville, TN <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-land.png"
	},
	{
		"id": 17,
		"title": "Property 18",
		"latitude":36.140701,
		"longitude": -86.793153,
		"image":"http://placehold.it/760x670",
		"description":"Horton Ave, Nashville, TN <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	},
	{
		"id": 18,
		"title": "Property 19",
		"latitude":29.424113,
		"longitude": -98.494830,
		"image":"http://placehold.it/760x670",
		"description":"Dolorosa, San Antonio, TX <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-commercial.png"
	},
	{
		"id": 19,
		"title": "Property 20",
		"latitude":33.440884,
		"longitude": -112.073876,
		"image":"http://placehold.it/760x670",
		"description":"Central Ave, Phoenix, AZ <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-land.png"
	},
	{
		"id": 20,
		"title": "Property 21",
		"latitude":39.099850,
		"longitude": -94.578720,
		"image":"http://placehold.it/760x670",
		"description":"12th St, Kansas City, MO <br> Phone: (123) 546-7890",
		"link":"property-details.html",
		"map_marker_icon":"images/markers/coral-marker-residential.png"
	}
];