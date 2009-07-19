#
# Copyright 2008 Darrel Herbst
#
# This file is part of Django-Rabid-Ratings.
#
# Django-Rabid-Ratings is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Django-Rabid-Ratings is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Django-Rabid-Ratings.  If not, see <http://www.gnu.org/licenses/>.
#

from django import template
#from models import RatingTotal

register = template.Library()

def show_rating(context, ratingtotal):
    """ 
    displays necessary html for the rating
    """
    return {
        'rating_key': ratingtotal.product.id,
        'total_votes': ratingtotal.total_votes,
        'total_ratings': ratingtotal.total_rating,
        'rating': round(ratingtotal.get_star_rating(), 1),
        'percent': ratingtotal.get_percent(),
        'max_stars': ratingtotal.max_stars
        }
register.inclusion_tag("rabidratings/rating.html", takes_context=True)(show_rating)

def rating_header(context):
    """
    Inserts the includes needed into the html
    """
    return {}

register.inclusion_tag("rabidratings/rating_header.html", takes_context=True)(rating_header)

