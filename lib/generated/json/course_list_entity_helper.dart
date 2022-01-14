import 'package:pay_buy_max/models/learn/course_list_entity.dart';

courseListEntityFromJson(CourseListEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['courses'] != null) {
		data.courses = (json['courses'] as List).map((v) => CourseListCourses().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> courseListEntityToJson(CourseListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['courses'] =  entity.courses?.map((v) => v.toJson())?.toList();
	return data;
}

courseListCoursesFromJson(CourseListCourses data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['course_outlines'] != null) {
		data.courseOutlines = json['course_outlines'].toString();
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? int.tryParse(json['price'])
				: json['price'].toInt();
	}
	if (json['discount'] != null) {
		data.discount = json['discount'] is String
				? int.tryParse(json['discount'])
				: json['discount'].toInt();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt'].toString();
	}
	if (json['updatedAt'] != null) {
		data.updatedAt = json['updatedAt'].toString();
	}
	if (json['deletedAt'] != null) {
		data.deletedAt = json['deletedAt'];
	}
	return data;
}

Map<String, dynamic> courseListCoursesToJson(CourseListCourses entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['course_outlines'] = entity.courseOutlines;
	data['price'] = entity.price;
	data['discount'] = entity.discount;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['deletedAt'] = entity.deletedAt;
	return data;
}